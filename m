Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC1E80E977
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjLLKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:50:38 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E325CA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702378242;
        bh=GwlfCoB8qgkK+r0YjK69x+ZVW2EkVeHBb5aLyX5erjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C5z8owUBMiqzaNdwjauPcZOD7zbMOQhAo3J1o6nLVkBIk1frEUfyRo34ih/Dcief9
         lMlT4EMBw7hpDb/vrHBD39VxStgMQ0vhJLaNo8AotTjgm9kcWZlbwSJ10+G2bWPAm+
         xn+k2TTuPZFtuvUMgFkZv29vCEnjGSFbGs6SwIGdufYLRKO5Uo3d74rVlAB7jY6Bgr
         kR0ldla6MY2G2qoSNNuKGOZZq6bv9OeKNJkAIv5RuG3qhQaMCv1/gp0JsJjRb6N1E3
         aTUOkemwjFLV2kCifutRDo3yxGSsF7v0lZp33epgDShD3zaUedfWA1LMpYW/lKONFl
         xFdTXq7pg8ddg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 309A93781453;
        Tue, 12 Dec 2023 10:50:41 +0000 (UTC)
Message-ID: <af322faf-a44a-462e-9ac8-0532cdf5824b@collabora.com>
Date:   Tue, 12 Dec 2023 11:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable configs for
 MT8195-Cherry-Tomato Chromebook
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122181335.535498-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231122181335.535498-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/11/23 19:13, Nícolas F. R. A. Prado ha scritto:
> Enable missing configs needed to boot the MT8195-Cherry-Tomato
> Chromebook with full support on the defconfig.
> 
> The configs enabled bring in support for the DSP and sound card,
> display, thermal sensor and keyboard backlight.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


