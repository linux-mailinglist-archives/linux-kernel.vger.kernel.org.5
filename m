Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A57A4581
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjIRJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjIRJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:06:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D1114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:06:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C1106607038;
        Mon, 18 Sep 2023 10:06:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695027984;
        bh=oof1nHN9tACZ947GQ2VLhaMIPFEc3JBhMrlsL+95qgg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U1vLZxQ3EcYiAWrB8+o60kkPxM97CglJ+EQd37dILEc0/AzOfm6wypcZrRrlt5YUo
         ilRMcrPjveo4nygcDiR1xXg+hjneKx7zXYkIFHhdlIZi7anpFq6MFRof8xI45YAiri
         QxXRESlGO0G2ncft8/IRDKM9be5NKd9bCbWSpxu3M+6P+e23W+B4hqhZ5hnq86iZ9E
         bkwHeC+ac6JtKmCMrfvc2SRCpDVZu4x5KdUTTTbIqA7Xm1NggQcn7RGQiFp1DlKDjt
         /f/nA/IvnOwrtUT0xEZGqJTyBWW5kvprNEvXbp4C+GqXNIP85hXeh0CS4XVVLwoZb/
         v2/BvcIvIzcOA==
Message-ID: <f2d33884-ca33-9255-5d88-64ad4c6d117b@collabora.com>
Date:   Mon, 18 Sep 2023 11:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 03/11] soc: mediatek: Disable 9-bit alpha in ETHDR
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
 <20230918084207.23604-4-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918084207.23604-4-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 10:41, Hsiao Chien Sung ha scritto:
> ETHDR 9-bit alpha should be disabled by default,
> otherwise alpha blending will not work.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

