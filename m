Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E117E2218
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjKFMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjKFMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:45:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0236C10F1;
        Mon,  6 Nov 2023 04:45:02 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D334C6607485;
        Mon,  6 Nov 2023 12:45:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274701;
        bh=HMBID2wavTIzdRH2nqkYR05h/eLJ8dQzC78ntnNIf8g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NOEDbqU4dykw5RVCGPDw3pdB8TohBlEdlcAyK5HyIJvoxplxYZmyEv3FNxzvkjpnC
         xWlTmHz1k8X9/cFCVMObKDgtcohZmkTe3bKgya2yMoCG5JLDxGqURpJ61IG4DHywcw
         yq9cDWBgUm8pyx9T+4Vp442g+9r1hSulVTHaBJXXo1k6X04IQvoe2Un1uugJaQv0LB
         9oIQfmXhFTZMo52NL+vXV+Wu0urZ7ZWNVjVsAh9mrhaoJ2dHTIMt0kq2LksFDfvuw7
         OtxgwWurEN0PvP8oHzmWQDWmw7yFixosYkn2SBtChtCg9piV2CiJZ8l4/n57Tmll6Z
         0mylws24MJPVQ==
Message-ID: <ee0250f1-007f-4b02-96d6-c5bc26da9c8b@collabora.com>
Date:   Mon, 6 Nov 2023 13:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/12] media: platform: mtk-mdp3: introduce more
 pipelines from MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-4-moudy.ho@mediatek.com>
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
> Increasing the number of sets built by MMSYS and MUTEX in MT8195
> will enable the creation of more pipelines in MDP3.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

