Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11B7E6652
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjKIJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjKIJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:10:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66321991
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:10:54 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 637F4660740D;
        Thu,  9 Nov 2023 09:10:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699521053;
        bh=42Ln2E9Xl3GRKOogFcQnIosDWOt7twPlXl2xjiL26lo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VEYf88+yOiO/9aKcpq4nOi1CS8inDpYYExslSKzAQKkas4kG19PXscZm7knfzqusG
         yZcpCjtcQGhSRcHH6tEAYNvZhiHPXoiq05WfbVabplih+WQi8q+tRRKIbGanj+3UXz
         nrzwtc6PFOJ5zC9Ex6OozzI9uiDKz444QFdx5AeaESxkKX4BXn6qj5VnP2v7Ufg8kR
         RaFnv4L4CKxkQ6GC2c9d5fqwNCI3A/LzHo32oVpsOA+UouS3C9QNWe2g7PZMECdjOu
         V4Pbm1fZjf85HCI/6iYjlrwYh93YBYwshxnC0Sk2JWHnJ2mKyPysYYpyPovzMycEY9
         fOYkBn/SgmsoQ==
Message-ID: <1cbecdd4-f99e-4227-be80-5b0163a61f5d@collabora.com>
Date:   Thu, 9 Nov 2023 10:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soc: mediatek: mmsys: Add support for MT8188 VPPSYS
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>
Cc:     Nathan Lu <nathan.lu@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231109082201.7698-1-yu-chang.lee@mediatek.com>
 <20231109082201.7698-2-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231109082201.7698-2-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/11/23 09:21, yu-chang.lee ha scritto:
> Add MT8188 VPPSYS0 and VPPSYS1 driver data.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

