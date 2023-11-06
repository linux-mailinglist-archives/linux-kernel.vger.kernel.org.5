Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBB7E2206
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjKFMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjKFMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:44:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9310A;
        Mon,  6 Nov 2023 04:44:46 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1D9E6607484;
        Mon,  6 Nov 2023 12:44:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274685;
        bh=g8+DvNuQKbxjlUkgBcDPFaIwsPe3rJhVET+PQDBrcyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ixjtni0UvpC54PNVQIDk6OX3M4TD+T7WE98VfWBY6567z2jyN5++ZCyUwOq+fHiVY
         NnSiXxSCmqoUID7CWKr2wMN7s/Cjor/qV41kMD7cvSyAkb8QzuwU6EdWs+p7+M/xlc
         bUSrHgXN45bIjP+Oy6XHJLAPpnAGL4Bq8iNMGWDAg/6Z0oEcs72k5HQm5RbkPA7dra
         r03cRIe8prA90RaUVnG/QYN5mqP65Gp2IYhs1BgvlDmYIGzzBT5qVRYs0AGUWhuD+M
         LHWgpF6ZCuNUd8cpMxgAZqLHQvH7bUPsEDLRD0jqY0pxIHPNBG2CQbIAIogachKxk+
         VGOIhoah3UXrg==
Message-ID: <fb267d23-e411-44c7-a49b-1c1bc2e8be2d@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/12] media: platform: mtk-mdp3: add mt8195 MDP3
 component settings
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-12-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-12-moudy.ho@mediatek.com>
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

Il 30/10/23 11:06, Moudy Ho ha scritto:
> Extend the component settings used in MT8195 MDP3.
> Additionally, it is crucial to read all component settings in
> a specific manner to ensure that shared memory data structure lengths
> are aligned across different platforms.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

