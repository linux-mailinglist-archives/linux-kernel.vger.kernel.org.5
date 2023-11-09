Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0D7E69DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjKILmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKILmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:42:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A12D71;
        Thu,  9 Nov 2023 03:42:43 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1593660748C;
        Thu,  9 Nov 2023 11:42:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699530162;
        bh=1GoPKkfelm7WA5wubXkX1TePXQHl6eXleQyR1wZu/jU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J7QjPbn+DCFzDj/lZM65PkFvyBeOgJ0X9MqINxhS2snOAqyP7YWlukAJHcOkytjLW
         FlFkqXsgIIh3btGhQm0HeLKpIspT/Jtw/9KDu+krYt4fXcPWrnNWffM1gcOlSsML80
         prO5jvjGdW9s0udCI/3tIO0viV9D868C1U5TBJdsrKmLbdYV6OsgVCnDH4MBgDga9w
         Mlw3osPw2glZYJZOsN4TbZrrpabskNJaY4U47fAvR0nliar/xJaOt00AAW8Y3bEA2O
         9bvJo73NWZzGmQZ1TbDruaY1btmEwFRfP9r8HiJftUKD4cG/VbaqyNm72drBiRY1fp
         TLPCY6OEnUZuA==
Message-ID: <27ee57f8-59a3-4834-8744-9b8107dd6521@collabora.com>
Date:   Thu, 9 Nov 2023 12:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND 3/3] dt-bindings: arm:mediatek: mmsys: Add VPPSYS
 compatible for MT8188
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
 <20231109111122.371-4-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231109111122.371-4-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/11/23 12:11, yu-chang.lee ha scritto:
> Add VPPSYS0, VPPSYS1 compatible on Mediatek MT8188.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


