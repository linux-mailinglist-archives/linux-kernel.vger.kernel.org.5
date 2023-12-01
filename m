Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519480067F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377979AbjLAJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbjLAJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:04:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694D12A;
        Fri,  1 Dec 2023 01:04:20 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20B256607394;
        Fri,  1 Dec 2023 09:04:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701421458;
        bh=nhnagN3QIK0LAGvvUn9dHDUJw+tv00vp1WX6wnM/hOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XEVG0CeSaqmj/V7PPVVh4yxVBrmnGN3m+w6BT1A+DSca6cl1o97zAdvOTJ9gp46E0
         cX+Y6jm4mBmgY+eq3q/cPVpqiEx35E6jEzhEr5KqlrU+jaZ+Tn1Sp5evm2jSq42N5R
         E77xxnafw6hEGmWbqVjXBbb5QN5vPY1AGcOmIQZBz6euZvS3N3IKLo3S3MncP1qxYX
         yaJEvVLJP3l2cEwgBCEihflRNzTrs46/v+wxNgfHNxD7uv/MOmv2QzwPAFq3UqGFoc
         QMHPFLmRNlmgz3vfJ0DRi5awn3EA12AJPkE9xF+i1BJGff4XI/AfkJTwrfH9TQhpMC
         fA0GNCKkLXSHA==
Message-ID: <22cc8650-a24e-43c6-bf7a-700becc93a1d@collabora.com>
Date:   Fri, 1 Dec 2023 10:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: mt8183: kukui-jacuzzi: Drop bogus anx7625
 panel_flag property
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231130074032.913511-1-wenst@chromium.org>
 <20231130074032.913511-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231130074032.913511-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/23 08:40, Chen-Yu Tsai ha scritto:
> The panel_flag property was used in ChromeOS's downstream kernel. It was
> used to signal whether the downstream device was a fixed panel or
> a connector for an external display.
> 
> This property was dropped in favor of standard OF graph descrptions of
> downstream display panels and bridges.
> 
> Drop the property from the device tree file.
> 
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


