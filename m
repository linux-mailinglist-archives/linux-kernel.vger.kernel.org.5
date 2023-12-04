Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD298036B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjLDOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbjLDO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3FD387C;
        Mon,  4 Dec 2023 06:27:56 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1073660711D;
        Mon,  4 Dec 2023 14:27:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700075;
        bh=9to/erUr86/0U8KBTbXriRV2fA+VN9gcEsoV5rt/ZGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WH7y/WFYqXrHBjzr9l9xgLJaoxz6QCDVNdpWirpn+Xmnz09D//y/YpwK+Q84W1dpc
         dsH2qGS9B5gNMAhVBL5Ui4DwHlwcGTpyQuXhKtHsI1UKvt5ZM9D6O9QhoVhvLozJQG
         m+mYXyQnoY5/Cyu4GmvYPGfLyPvi0kznOD/fX+R/IR3zl4sAWSG9wQH6Da1YlAAqZN
         A0ltDN3NDvFi0FxCAcPkigzViWghkO1eCSMk8SCvEduIXUiMCVNrEj2b4x0U9u62IM
         9jkcKvIY5GG2PDkVHhl4KK0mINPemJmFgnfGW611a2p3sQiOvspfQjOpxqPRVVnr0Y
         aBaAqX0b7RDKA==
Message-ID: <ce1bd340-cfc5-47ba-849b-1ee429b75c1a@collabora.com>
Date:   Mon, 4 Dec 2023 15:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty
 Chromebook
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231204084012.2281292-1-wenst@chromium.org>
 <20231204084012.2281292-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/12/23 09:40, Chen-Yu Tsai ha scritto:
> Add an entry for the MT8186 based Rusty Chromebook, also known as the
> Lenovo 100e Chromebook Gen 4.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

