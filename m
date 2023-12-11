Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E566380DC82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjLKVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbjLKVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:01:51 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D43CF;
        Mon, 11 Dec 2023 13:01:56 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1rCnPW-0007EH-00; Mon, 11 Dec 2023 22:01:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D51F5C028A; Mon, 11 Dec 2023 21:56:22 +0100 (CET)
Date:   Mon, 11 Dec 2023 21:56:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink
 architecture
Message-ID: <ZXd3dhsc3HXbj7SR@alpha.franken.de>
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 11:06:33AM +0200, Sergio Paracuellos wrote:
> Its been a while since I am making contributions to this architecture.
> Hence add myself as maintainer.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Hi John, if you are not ok with this please let me know. In other case
> please ack this patch. I can add myself as Reviewer if you prefer to
> maintain alone this.
> 
> Thanks in advance for your time!
> 
> Best regards,
>     Sergio Paracuellos
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2894f0777537..406c26a6f5d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17914,6 +17914,7 @@ F:	drivers/media/cec/usb/rainshadow/
>  
>  RALINK MIPS ARCHITECTURE
>  M:	John Crispin <john@phrozen.org>
> +M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
>  F:	arch/mips/ralink
> -- 
> 2.25.1

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
