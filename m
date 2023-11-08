Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C37E5357
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjKHK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbjKHK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632F1BEE;
        Wed,  8 Nov 2023 02:28:46 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47BFC66074ED;
        Wed,  8 Nov 2023 10:28:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699439325;
        bh=GcdHSJgeWmGJHtZ0x7dgpKg31f7UCRSoxm5HSXeUxRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OWOcC1BhTdlJM3ym30ZgZXQjJCqmdW2mFzl+wEdTSILf40dl1hzI9LgQjOxv0elap
         8NsGvetL9Yh1Yx6shGwMW3lKKMwd2kPfskgU2NTgkuhJk8jnTqb2KBzgTFU/lKYLgz
         vTGbNUSxgHb1lYK5ZUQ7g8RBj/soMmxG9Si/4oimWQ7E2VxwfXvp/p4aLr0ZdhOHBF
         TA2DkvLt1aXxIiwHDsvjV3+ba0rxQEZFfVxpBHnPSG7zQGXWWuxS9htJIoyrwl6di4
         rmzxDp4qZh5SjdIVZb664dRHGrNH/YrfWPHVliYc5WxsadqetM8YbWrGpJD2Co5H+Q
         HAwFCrAQFy3Dg==
Message-ID: <f45ab1e1-8c42-4923-9fa4-fc93cea8cfe0@collabora.com>
Date:   Wed, 8 Nov 2023 11:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Add SVS node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230710025834.20513-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230710025834.20513-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/07/23 04:58, Allen-KH Cheng ha scritto:
> Add MediaTek Smart Voltage Scaling (SVS) node for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


