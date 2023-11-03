Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA67E004C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjKCIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjKCIbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:31:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1786D44;
        Fri,  3 Nov 2023 01:30:58 -0700 (PDT)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C8FB66073C9;
        Fri,  3 Nov 2023 08:30:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699000257;
        bh=hLNERQKYSutn1+nzWzkjaZyBsSN1vmekpilQjSSBvnM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a5olgv2+2bKK9cdt3dTFCVaVCWwFsldoYKQYekZhFqRkLjFoYyMfAZtAbVIHPob8H
         gjmglpPAsAsfPfQ8GZ5NVXC81IM09i+WmxKOkRW9fMk2gT0w0IXq4yhBwrngzbG30n
         Kz62r1vExIyg/wmwUZKjq6fP0a7pkmG8f1iwMGxSFY/gqWw0Bu0ISiYDzNbxDdpnzO
         ESXyiqb3KTBrmfD6OCASPQKGHcEGfuOrL+nmXPmyZXFTYjEpfnbLZhQeNo9qqpeoTe
         hRXA+wjog+6i69RUnJy/vm8KPICEXgWJh2NistTjPzYAPQWqb0Hm4HxTD21XcQld69
         L5wn5JNOAAvjQ==
Message-ID: <ec054c43-f4c2-492a-9da0-65a8235c7bb9@collabora.com>
Date:   Fri, 3 Nov 2023 09:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial:
 fix error messages
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, broonie@kernel.org,
        jiaxin.yu@mediatek.com, linux-sound@vger.kernel.org
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20231031103139.77395-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231031103139.77395-1-eugen.hristev@collabora.com>
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

Il 31/10/23 11:31, Eugen Hristev ha scritto:
> Property 'playback-codecs' is referenced as 'speaker-codec' in the error
> message, and this can lead to confusion.
> Correct the error message such that the correct property name is
> referenced.
> 
> Fixes: 0da16e370dd7 ("ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


