Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C19797B85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjIGSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbjIGSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:19:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A29121
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:19:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19389660730D;
        Thu,  7 Sep 2023 13:17:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694089029;
        bh=+ZEmJmzjGb2pOYORx4+WouiDGRIQVqAsgte7HXYYAmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gv4C6/9p+aSstBoY/hH6uNhgjOjUD6aRAu9+CCIiVJb3XImDtYlssSyLCLXQAj67F
         lciXdUz1CoNdTvwMr4thfnWhCZEQW0OzOy7IKdo2orRdO7a31s7xm8a+zfy8+vSsf3
         LkKmTnfHzXSq0TeoUtC8IkvTf8zKwIa0pmdlJcJaVgh+78ppR3QOGpb6DHKvQp+4KX
         mlGGpU4bCSS27hsIIb6fEw01oGQVQw6DKiSzKzzA0gUxg6tsOqY/NLCX2y/zEPszR0
         nSW0TmUEV3107uWiS5ZxTQccopa3FaIjkDGTQbJp5FXIDsTIUy8XC6yT2eicGZBrnr
         U1/GUfDaP4IJQ==
Message-ID: <8f5a5e7e-ca4c-3f3f-08fc-bf9591060cdc@collabora.com>
Date:   Thu, 7 Sep 2023 14:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/15] drm/mediatek: Support alpha blending in display
 driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-6-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-6-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
> Support alpha blending by adding correct blend mode and
> alpha property in plane initialization.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


