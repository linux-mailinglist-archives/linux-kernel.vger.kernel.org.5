Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8C7E221C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjKFMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjKFMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:45:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6AD7D;
        Mon,  6 Nov 2023 04:45:09 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E97556607486;
        Mon,  6 Nov 2023 12:45:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274707;
        bh=KHdEdBoTKIDChsrZTrn1ERogMs2DnzZBA+ApjWHSpI4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D+DtbvEYMPLs2SjTUM7pHIzPPvSha48oZL8Fh3AS30oxThWNStBgfDaP1ngiICrfJ
         09akAG4QfE4lbUDVBJuUwsKfR6R4uOrXJY3KBnKU2VWhFD74JNXNKYkaoOTa3xGq92
         p3UdZ5uwygVeoKpy3QspBfQT46iXVK6AHMwAdF3tWMJEbUarYxnsxhO2YqFv1IbKet
         V4ZePUVDVJi6JPZJZpN+aX4+CxapBq+ieNsDQzrcV8DDcya7RFYAgoTT4TGPbQ/kc6
         2suU1Wd8Y2xZ/KZPHvv8sUK4gtDEbBLR8EjyyWgxDo7W1d1PWgMxevWxB9gsfh1tZh
         VjnPG9ucfQ4xg==
Message-ID: <484fc9c7-e8e0-4bed-ad78-edf455a17f37@collabora.com>
Date:   Mon, 6 Nov 2023 13:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] media: platform: mtk-mdp3: add support second
 sets of MMSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-2-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-2-moudy.ho@mediatek.com>
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
> The MT8195 chipset features two MMSYS subsets: VPPSYS0 and VPPSYS1.
> These subsets coordinate and control the clock, power, and
> register settings required for the components of MDP3.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

