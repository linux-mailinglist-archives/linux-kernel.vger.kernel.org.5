Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9407E220B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjKFMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjKFMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:44:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197EF3;
        Mon,  6 Nov 2023 04:44:50 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3FBF6607482;
        Mon,  6 Nov 2023 12:44:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274689;
        bh=sIoSRSvrBOcmnZyMDW2tZsC9ee5C1FKmhrM2pG1tRTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=agBS2/3HpPU9vDbTkdEX9hp9mzVf9XrqraVuEwEE81Xk5SlmL7TskhXLPGYaGmpaQ
         6YusfspnRafW8+cb/MOFxx0VU2gChc4MuM+0oW03AlWn8/+2nj+zbtbeNMPOTYYK+V
         B/4KbYdoEVdHmJjpLTnGKSDdtjtN2e8j88Ce7Fjtnw+kiQhcBOWUAp9y9vhgBJKlG5
         dfld29UkyMvCsC5Yez2jr0XulIi31c7+CKl2xVNT2vvluhVP5eiHGS8fWNnXB7K1Sx
         2BtjKuWzZVQO7MAPRq9IXznvmFHybKnzCMVfA81ZS/fkS/qj52ccI+1brVirsFaTTC
         SbYPxJQNoz24g==
Message-ID: <9edb66ef-a1a8-4278-b505-5486196ef2ab@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/12] media: platform: mtk-mdp3: add support for
 blending multiple components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-9-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-9-moudy.ho@mediatek.com>
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
> Certain chips can combine several components to form complex virtual
> units with advanced functions.
> These components require simultaneous configuration of their MODs and
> clocks.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

