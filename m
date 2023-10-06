Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064547BB7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjJFMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjJFMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:38:27 -0400
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428FC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:38:24 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ok5zqNRDGRbLIok5zqXul2; Fri, 06 Oct 2023 14:38:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696595900; bh=+Vi3CNkLL923Lc+E4OFWJ7cr/sftotS9u6XSjMvqcXk=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=Je+7GG8IHeaPYFuOXLb8gP4brgdGl25dVroRVBjHxgu2VfoaBqrzw+1/AJV3vom1e
         53ZMmICLh66XFtzpLyKV9Bce8crjdX68aJCTUk9CPBoB+n7c6EcKZ4xNKx8Bpi8M7m
         rQP9yMWK9m9Jeuhyrm9SA9Ao/XfUc6j6J7KXKL25Y2UHWj9vKfxlZoTVbWhNk8+X9L
         ptuA+kntFw5VapGntF1L9Rs3I1Od99v4tnAEa5E8w7qGoC0j6f9/g08O8rPHnhbFw8
         4H3tChtfXG9nigL5GKP8R70h9mrQ8eYR3aqKRm0TSVso4lHmubJmU5cCOpjL4oNxQV
         hmMFhwruAJr5Q==
Message-ID: <539bcab9-e8f8-524a-c14b-a5879ce4415a@enneenne.com>
Date:   Fri, 6 Oct 2023 14:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] Documentation: driver-api: pps: Update PPS generator
 documentation
Content-Language: en-US
To:     lakshmi.sowjanya.d@intel.com, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, pandith.n@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231006121531.22450-1-lakshmi.sowjanya.d@intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20231006121531.22450-1-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGOrjqQZD8VuRDeDnELn8tKnRLD5NoH+6fIeey6Y5s7Ot9VriDTYsg78/q+GCjoms9J9nqkkMiU6vKy0Ibul+EzSrVpR7c2ZIpN82snDPc9yTHXd21R4
 +9ZkNcFqN5jTKstDAqqt0fCN7WRy2ygvRcRXLOEgl6g01W/m4W6l/XdyTS4VdzApG4ggyV3x4qHh9xXF33EYtPnCgRDo7NLsFTFpH54KkoNDe6YMEfYPYqwf
 L8m0HRxGIwMZIshI7K950lFl3H5NG7UcsVcJ9m3A4zqJ5pQaN+edwMuL0s+ArVnKqTAj/WHnaypOPaKTx6HmS7rfWGCT/8wTf3f99IfhDCZ0dRuZAu/+OMue
 PA4UtGL/
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 14:15, lakshmi.sowjanya.d@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> PPS documentation has a generalized section for generators. Update the
> section so any new generator documentation can be appended.
> 
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>   Documentation/driver-api/pps.rst | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 2d6b99766ee8..78dded03e5d8 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -200,11 +200,17 @@ Generators
>   
>   Sometimes one needs to be able not only to catch PPS signals but to produce
>   them also. For example, running a distributed simulation, which requires
> -computers' clock to be synchronized very tightly. One way to do this is to
> -invent some complicated hardware solutions but it may be neither necessary
> -nor affordable. The cheap way is to load a PPS generator on one of the
> -computers (master) and PPS clients on others (slaves), and use very simple
> -cables to deliver signals using parallel ports, for example.
> +computers' clock to be synchronized very tightly.
> +
> +
> +Parallel port generator
> +------------------------
> +
> +One way to do this is to invent some complicated hardware solutions but it
> +may be neither necessary nor affordable. The cheap way is to load a PPS
> +generator on one of the computers (master) and PPS clients on others
> +(slaves), and use very simple cables to deliver signals using parallel
> +ports, for example.
>   
>   Parallel port cable pinout::
>   

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

