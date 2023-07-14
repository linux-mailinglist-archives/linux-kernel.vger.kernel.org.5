Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCC753E60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjGNPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjGNPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:04:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8F2700;
        Fri, 14 Jul 2023 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=qkCLhchmFE6Ae0iC8ZYvyTVa+UOqDTQhu4Aq6+1S4Xw=; b=lBOjZeMIMEUpxXjADFtB3DDa77
        Sssnp153TrRmreFV3fpKhKKAR9RmFUQ9/sx86lLWLcSt7JvFsYwaS6EmQ4ah9MMlG8HtPhRhcJ15g
        TbkbeNO1mo6++2ARehIbb7ptpTZ1Kq8snGkUvGhpD4FHJXbE0cDfNYrIgaZ/n+xI0fd8Ym7b105kv
        S/ktaDSWFC+d9pDEBMJDxwR8OJlZ/wTJ9i/sPeVPc/gD5kZXoVoqPNpr9UFHH1p0Q57kMavNI4tqB
        +dFoIHzlP8ZzxjophTo2TZSsuZmEIjnWNNAa1rp2hmlGpXNU0hrvmNGFX047YrfCnbxpzkHUUplhV
        KdH/1tqA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKKL7-006TC1-01;
        Fri, 14 Jul 2023 15:04:13 +0000
Message-ID: <ccf1e027-1f36-3dfb-af65-c7eea27c89cb@infradead.org>
Date:   Fri, 14 Jul 2023 08:04:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] MAINTAINERS: soc: reference maintainer profile
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/23 01:47, Krzysztof Kozlowski wrote:
> Mention the SoC maintainer profile in P: entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Yes, please.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f646ba70a01b..b61289fa7891 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1558,6 +1558,7 @@ M:	Olof Johansson <olof@lixom.net>
>  M:	soc@kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +P:	Documentation/process/maintainer-soc.rst
>  C:	irc://irc.libera.chat/armlinux
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>  F:	Documentation/process/maintainer-soc.rst

-- 
~Randy
