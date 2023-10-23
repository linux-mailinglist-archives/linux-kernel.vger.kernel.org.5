Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A667D2ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJWJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjJWJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F75FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:50:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C29666606EE0;
        Mon, 23 Oct 2023 10:50:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698054624;
        bh=aA6ESkypsjz5E0SurIMDE0S1ZQYHkS4/L2TIdvlGBnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kn3tWDPHCBaP4raiGT0kwFXFW4iXv4ed+RaeZqavGZ/1gv0wVgLsft88MbOtl61a6
         D4FlF8d+do6USOyIZomvPWwG4Q8C/FDC7JU/eJepWcW3n6nBAlgHR3ebBCZ2p5uqiW
         tU+yg/FrOs3VO/NxU6inArO+93sSdJRBen6wPT8G2xL7mIg467uM5JU1VvGgmAQ+nw
         Ra/4A5dbLGlawIGks32V65ZbJIkFEA2l0hKrWIk/25LfENSh0jCwOBZpQcKfMmB7bW
         0twji3N8p4BKOGNaPzRkQE0Ow2K+56ZVU7+/b/d98g414yaBlTBq8i9HMFIIAvco9Y
         fLqge0Cqc/OTA==
Message-ID: <72277a7e-83a6-4947-8f2a-4881aa8ac766@collabora.com>
Date:   Mon, 23 Oct 2023 11:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-7-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023043751.17114-7-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
> Add CMDQ driver support for mt8188 by adding its compatible and
> driver data in CMDQ driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Please fix the commit title...

mailbox: mtk-cmdq: Add support for MT8188 mailbox

Regards,
Angelo

