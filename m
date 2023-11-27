Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3737FAA81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjK0Tlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Tle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:41:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE285;
        Mon, 27 Nov 2023 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OsdhkKJ5OBibEks8cALyIRkF9z2Sypb7e/dUXuahLro=; b=gmFwaDNnI3MpTvA3NLaNqMx6n2
        qOsXPFM40yQEZRD9AO4GKWLKA4BNpM6SVFRUKvduXXFptAPkgP2LVAmvi/DQCt2hVfI7MbAux7R9q
        qizF6/lDqadMjTBNTse9KqK0tlBXuwoSwl+UZ+h8vLihwv2bYokQZODkeNrfNyo2S3UGb+OkNtCwg
        3hBVpJZrdpMhWofoZSmXloSecC+MiY9bWFajhAz7YakMGYR9ZMM6AMd3QZGwqunq4EBvMPH3BKOko
        dsXswAgGMge/iiBtnZ12fiTWlKzjZNjRVb7ecvBA7jNi0CF78o4gR8yIW5v4MB7QN1C+rOzSp8iAS
        Q29QGwZw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r7hU5-003NeL-38;
        Mon, 27 Nov 2023 19:41:34 +0000
Message-ID: <202dbdf5-1adf-4ffa-a50d-0424967286ba@infradead.org>
Date:   Mon, 27 Nov 2023 11:41:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Took care of some grammatical mistakes
Content-Language: en-US
To:     attreyee-muk <tintinm2017@gmail.com>, jpoimboe@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, corbet@lwn.net
Cc:     live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127155758.33070-1-tintinm2017@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231127155758.33070-1-tintinm2017@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/27/23 07:57, attreyee-muk wrote:
> Respected Maintainers, 
> 
> I have made some grammatical changes in the livepatch.rst file where I
> felt that the sentence would have sounded more correct and would have become easy for
> beginners to understand by reading. 
> Requesting review of my proposed changes from the mainatiners. 
> 
> Thank You
> Attreyee Mukherjee
> 
> Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
> ---
>  Documentation/livepatch/livepatch.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
> index 68e3651e8af9..a2d2317b7d6b 100644
> --- a/Documentation/livepatch/livepatch.rst
> +++ b/Documentation/livepatch/livepatch.rst
> @@ -35,11 +35,11 @@ and livepatching:
>  
>  All three approaches need to modify the existing code at runtime. Therefore
> -they need to be aware of each other and not step over each other's toes.
> +they need to be aware of each other and not step over each others' toes.

I've never seen that written like that, so I disagree here. FWIW.

>  Most of these problems are solved by using the dynamic ftrace framework as
>  a base. A Kprobe is registered as a ftrace handler when the function entry
>  is probed, see CONFIG_KPROBES_ON_FTRACE. Also an alternative function from

thanks.
-- 
~Randy
