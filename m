Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65ED7E7478
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjKIWme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjKIWmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:42:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086C4206;
        Thu,  9 Nov 2023 14:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nlxtm8iPjIlU6MpliGoSH8MTvH0ZUVGjRXOD+O+7QtQ=; b=2L4JpmeSdAm2UL2l6hsrZkpXgB
        ILdYhYoiutv77BSZkY7wr4cSyaoH3ZvCisq52HcdTdz6+YgcWUIuV9doQzOBKmIX6XUlqnd68+G/V
        EfHzJ/emt9tgkUOkgYROqzKc7RCazIrPBQptgsV5nf7VOU7MVgYwXbQ8JQ6ts+/ErCB7bha2Vnq8I
        4ScN3wcvdsWvqFTr7tQ7ufJe/tLk/SziJfXEwr5E7lLsGjGezB3Lju91HZ1eixAAUvZR+/FuSKBox
        m7rwiG0howk7jsghlneEqtMdBDD088WCIeJbgOBcYLr7GaiBc/edb9uxn3SMoiRxyNGJyI18QrMQj
        LUngoBqQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1DjJ-007Md1-0j;
        Thu, 09 Nov 2023 22:42:29 +0000
Message-ID: <cc37a0a9-8329-4b46-9349-e36844092e0b@infradead.org>
Date:   Thu, 9 Nov 2023 14:42:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: samsung: Improve kernel-doc comments
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231109190925.2066-1-semen.protsenko@linaro.org>
 <20231109190925.2066-2-semen.protsenko@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231109190925.2066-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 11:09, Sam Protsenko wrote:
> Unify and improve the style of kernel-doc comments in Samsung CCF
> framework. Resemble more idiomatic style described in [1] and commonly
> used throughout most of the kernel code.
> 
> [1] Documentation/doc-guide/kernel-doc.rst
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-cpu.h |  30 +++----
>  drivers/clk/samsung/clk.h     | 158 ++++++++++++++++++----------------
>  2 files changed, 100 insertions(+), 88 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy
