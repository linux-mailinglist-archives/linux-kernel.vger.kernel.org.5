Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0DC7B6D26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjJCP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbjJCP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03583;
        Tue,  3 Oct 2023 08:29:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 584182B4;
        Tue,  3 Oct 2023 15:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 584182B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696346979; bh=oNUby9XoxXYW+ywghbCQz8OGhrcdvFoA3zgc0D1Xcyc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lRCUJqTMidwGRV+lkM0cG4LmPCsWS0MIWym7YpiISEskhUvjFR1sbQ35gt3PH+Wo1
         AsMzAtwpLQLlsgqTzrlcTpTIUv8I40lT+3YaYeplNiO6XH1oXBp/JFg1hs3rZE1rla
         X5e/ZK+eBO+uAaQYfbjZ0U3QhjJpfRYTUkkaltgJhzaxQHaM2ai90SWKxwyLRi1DL5
         BRGSAX6N9iPDlH56edUisNgqrAHSvY1p5bPBgck9UP36xL8akde3YO/+H7gXApKwPU
         uzM2yOKOE1lHf7Z3Ja51jEDR3P3FMgdL6GLSnlrU9HeBt0DuoV6XSwv1JpwUT3ycrX
         WP4fZVEp3RCHw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jianlin Li <ljianlin99@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jianlin Li <ljianlin99@gmail.com>
Subject: Re: [PATCH] docs: x86: Update spec URL in x86/iommu document
In-Reply-To: <20230923071344.540894-1-ljianlin99@gmail.com>
References: <20230923071344.540894-1-ljianlin99@gmail.com>
Date:   Tue, 03 Oct 2023 09:29:38 -0600
Message-ID: <8734yrg1wd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianlin Li <ljianlin99@gmail.com> writes:

> The previous link to AMD IOMMU spec is no longer available,
> replace it with the new one.
>
> Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
> ---
>  Documentation/arch/x86/iommu.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
> index 42c7a6faa39a..41fbadfe2221 100644
> --- a/Documentation/arch/x86/iommu.rst
> +++ b/Documentation/arch/x86/iommu.rst
> @@ -5,7 +5,7 @@ x86 IOMMU Support
>  The architecture specs can be obtained from the below locations.
>  
>  - Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> -- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
> +- AMD: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_3_07_PUB.pdf

Sigh...how long until they move it again?

Applied, thanks.

jon
