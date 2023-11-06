Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A97E2216
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKFMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjKFMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:45:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F910D3;
        Mon,  6 Nov 2023 04:45:00 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 482CD6607483;
        Mon,  6 Nov 2023 12:44:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274698;
        bh=uhAf/mZ82cApzSh3+dO27vbS+C6yfFCJQj4sXp6ctfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e0s6R0JWQXwywvKnx9Dd4KUQHtLsUS0p9j53qUXjY2s9mMYmmlUUFy5LRuzvsIsJQ
         5v1N8Uv7MnTgbNzIEwA7s1KmGdm8nvxzSixCG6qX0xkYH075qIpnETwAu23vA2NtKa
         e8PQmdhk+aRD08yEjZ4QKk10jBqZimwAYHpuldetLpa9qFEPguohO7G7vCEUUNqyoH
         dxhcjQaVvmss5bvNrs0BqnQyYs/0/OpO67GKuTQJ6qMFVJGcE9Axqzc/nTcNYvBD4x
         AWQwj7yfI/XqbRTeofQt3pXEhC8XEGfKpVe0C9VYPvnuh1xYFqzxte2KY7yH8ELVTI
         keObYxWi1ygmA==
Message-ID: <adc02879-b27c-41be-a496-3c3d9def4b70@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] media: platform: mtk-mdp3: introduce more MDP3
 components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-5-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-5-moudy.ho@mediatek.com>
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
> Add configuration of more components in MT8195 MDP3.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

