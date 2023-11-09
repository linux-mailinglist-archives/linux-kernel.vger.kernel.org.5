Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DED7E69DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjKILmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjKILmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:42:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F72D77;
        Thu,  9 Nov 2023 03:42:43 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A21026607498;
        Thu,  9 Nov 2023 11:42:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699530162;
        bh=r8ruF9YN0L4bEEkLdhc4a/eZmk8kyZoR/y8lsZMRFMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GO6ismQD+TCUhDDFoIEGl9sJWRQIIqppa+4/l6Cr1nA8E08ebnKUsYU4prI0B9lSE
         c5bwa2Q3LNiSKTyV6+SE0JJUAJ5j6g+LTopIFFAS0xQPBSIVeFK58pnoyInhxdBnEJ
         aKOaCAntUf9iRwrVYTkiIRouSXO0RY+ukcRmhggGB7vd86fmpoJ8nMkx/UsQ9TL73S
         oPr5JXNDvhgEG8mGyIY47KZomwo3w/4/ZbKwx+Gbdy5LBk03xTll9Y9yQ19r16qoY7
         Nfi5lKLYQrrZCzvk4pD5jq/++GQnBOQgrHIi5zfuHdK68QoJ7JGfxxzrtM6ruYH3Nb
         s7tyZJebzfkFw==
Message-ID: <da47a3bc-3170-471a-acae-6c73e236b2c2@collabora.com>
Date:   Thu, 9 Nov 2023 12:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND 2/3] dt-bindings: clock: mediatek: Remove compatible for
 MT8188 VPPSYS
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Nancy . Lin" <nancy.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Garmin Chang <garmin.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231109111122.371-1-yu-chang.lee@mediatek.com>
 <20231109111122.371-3-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231109111122.371-3-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/11/23 12:11, yu-chang.lee ha scritto:
> Remove VPPSYS0, VPPSYS1 compatible on Mediatek MT8188.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


