Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F018036B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbjLDOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjLDO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC7385B;
        Mon,  4 Dec 2023 06:28:00 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E13986602F41;
        Mon,  4 Dec 2023 14:27:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700079;
        bh=bfapwJdkzqPcsfip/eT91Kiy3Iw24DAJc9myhfYq34E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ortWT5peN4C0KFlle0eQcfnlGt93ncNSnIwtkvAW9hooItu6jrq0qzIUqksvzOdV2
         jCnCK5qLUwCEgoi/7hSH2pNKZklDjrdG2xWOTc4GnSw1wdsiT9xqe5oc6kDU7blspZ
         bLhltJl/yw/AJZ4B0WGYaah7tj0XDTqbun7kve3T+Gml7qz2QXKbH957LCCtSIR/5e
         F+hQdMUvYZG9o3CHI0JAztgWCegj/DiWoKZ57R8fnDt0q9MXifIl777KW5Zx7OnotP
         NcODeOFmoprmcsGwDp1Dvfuhmcby+YkfuclO2y1wdvhhN3CCk3MjlYqN65EIuCOMth
         T5xhr26MJUl+Q==
Message-ID: <3f97b10d-6def-4c77-8382-e1c56e8f16a2@collabora.com>
Date:   Mon, 4 Dec 2023 15:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel
 / Tentacool Chromebooks
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
 <20231204084012.2281292-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-3-wenst@chromium.org>
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
> Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The two
> are based on the same board design: the former is a convertible device
> with a touchscreen, stylus, and some extra buttons; the latter is a
> clamshell device and lacks these additional features.
> 
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
> but is incompatible.
> 
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

