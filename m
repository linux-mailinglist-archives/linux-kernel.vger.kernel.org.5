Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52CE7D235D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjJVOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:33:09 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5426A3;
        Sun, 22 Oct 2023 07:33:07 -0700 (PDT)
Received: from [2a04:4540:1404:4900:1941:1c3a:856a:fbea]
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <john@phrozen.org>)
        id 1quZVo-00EtoG-0Q; Sun, 22 Oct 2023 16:33:04 +0200
Message-ID: <1d6804f3-a5e2-4840-a4ae-7cd2632b3b64@phrozen.org>
Date:   Sun, 22 Oct 2023 16:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink
 architecture
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
Content-Language: en-GB
From:   John Crispin <john@phrozen.org>
In-Reply-To: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.10.23 11:06, Sergio Paracuellos wrote:
> Its been a while since I am making contributions to this architecture.
> Hence add myself as maintainer.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: John Crispin <john@phrozen.org>


> ---
> Hi John, if you are not ok with this please let me know. In other case
> please ack this patch. I can add myself as Reviewer if you prefer to
> maintain alone this.
>
> Thanks in advance for your time!
>
> Best regards,
>      Sergio Paracuellos
>
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2894f0777537..406c26a6f5d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17914,6 +17914,7 @@ F:	drivers/media/cec/usb/rainshadow/
>   
>   RALINK MIPS ARCHITECTURE
>   M:	John Crispin <john@phrozen.org>
> +M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
>   L:	linux-mips@vger.kernel.org
>   S:	Maintained
>   F:	arch/mips/ralink
