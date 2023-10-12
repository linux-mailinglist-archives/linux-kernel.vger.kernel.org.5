Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BB7C6A95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbjJLKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:10:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA9B8;
        Thu, 12 Oct 2023 03:10:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 187BE6607341;
        Thu, 12 Oct 2023 11:10:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697105431;
        bh=bOVsBp/GYCnnxUwNLIqNBQpgkKjP3xcUOyT6AhRFAeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WVVm7ISlCZxqkXFh4ijyyMA+1xQz5Q1FNii0p+fN/3crKTCe9r6PaaU/MyC4gADSP
         XuX9XhYsxeXz7290WaFUGcs0H//wFp6UDr2fN6CDeUdPhOU+mQkD4m1v7fZRRiDAfA
         U1PSjjEJBhbNILg2eIjrwP/crH+Px05F+Fby3F3yLQxqME90kv+1ngk4t+UOaYz1rV
         aMIdaCD43ywi7qLUj/BJPRH2Wx/qJJl+/34U023pUQeYm0v3mBNgSor3ZRg0h3K8S9
         F+ktZCU4xX9H41YGznJLkZiSKn9zpraEqvDvej5i/uQzIOchwJ+QCv8LNMzO9mP7yW
         iFfoDE6o1mB2Q==
Message-ID: <5e2854c9-f248-ea8e-02e4-f94cddc28e5a@collabora.com>
Date:   Thu, 12 Oct 2023 12:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 13/16] dt-bindings: display: mediatek: merge: add
 compatible for MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231012084037.19376-1-moudy.ho@mediatek.com>
 <20231012084037.19376-14-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012084037.19376-14-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/23 10:40, Moudy Ho ha scritto:
> Add a compatible string for the MERGE block in MediaTek MT8195 that
> is controlled by MDP3.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

