Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352367850D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjHWGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjHWGvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:51:46 -0400
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DCCF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:51:43 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id YhiOqO4bYk8qWYhiOq4VvI; Wed, 23 Aug 2023 08:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692773500; bh=O9WPQUPAKAGvp3DSLKyfLAvd3RdLvzDYP/gzAoqU838=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=XYteHM6S12liZENcRJTz33c6xi5HF7wNXZQ9GOzZyn4G70naDaHCoz7Ce0wJzWlOt
         JNWKRhCF8V1fci0VjZjtf6I3N6MeHesVcFhgtp/vz5DtOKX3dob2V6OUK7b89SDgBJ
         uvWiLcybT5/yH18IbMjchVqzIEhtKHPXY2mKk6ZP8SusY5VywBLuCLigdccIP4QmUU
         i5BnjscnUV+OkDfno/aZzy75lwgRB+bqlUN6Gwwc+us8W523irinF5yXgA86Mi/t99
         Z19pL73L9KJNSU3LXjCIbeTIVb7yKuhBKlyREM63rjYwO4xCe5FX3HvuIoSjy9SIFi
         5uezECqs3n59w==
Message-ID: <6df89394-7f38-4774-52a7-0a3bee10cc65@enneenne.com>
Date:   Wed, 23 Aug 2023 08:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: pps: Update pps-gpio bindings location
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, robh+dt@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        kernel test robot <lkp@intel.com>
References: <20230822213317.60798-1-festevam@gmail.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20230822213317.60798-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH1+oGyIRzo0mjVgKajO3hPRBZYOReUcY4Y9cjkHmlK0L7ofIVF/8pEy0FTSUzdg+bBno0dNpvuGy56aWtrtR2HZRP+m6R88jdcyDub+2LE/FaVuY6Q2
 n1F/O/lPjUZhJsMaFwlezn2uZymU31bFmvHYWdyHxyJrF2gu9//Nx3v8iVh5BwRG5yWSLo5yF2eqC8z/Xfagu0jFyiRTr9qVvpeLy/LedvZ2aSbfQhwYiaFJ
 f/8UhcwEyTwJs+E1gyky8qb4a5HPPF75lxu6WadlCV66zyreAk0NNQvlFOvM371yvcdOT80nV8AhoafQt3nJKm0cylOuX6LY95smxbKayEta5dtfoF5eTx5L
 yceEE8s/
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/23 23:33, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The pps-gpio bindings have been converted to yaml.
> 
> Update the file path accordingly.
> 
> Fixes: 7ceb60ece856 ("dt-bindings: pps: pps-gpio: Convert to yaml")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308230517.n0rrszYH-lkp@intel.com/
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf8dd33048ba..afde89d9b7ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17132,7 +17132,7 @@ L:	linuxpps@ml.enneenne.com (subscribers-only)
>   S:	Maintained
>   W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
>   F:	Documentation/ABI/testing/sysfs-pps
> -F:	Documentation/devicetree/bindings/pps/pps-gpio.txt
> +F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
>   F:	Documentation/driver-api/pps.rst
>   F:	drivers/pps/
>   F:	include/linux/pps*.h

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

