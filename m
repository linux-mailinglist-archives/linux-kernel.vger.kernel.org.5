Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42167BDC59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376354AbjJIMjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbjJIMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:39:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD75AC;
        Mon,  9 Oct 2023 05:39:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 203C0660716C;
        Mon,  9 Oct 2023 13:39:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696855188;
        bh=lS76ocpZeANuMGXYVZLnsbTidODtHxIumr0VpieWrD0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jt0iKC8R9Wx4opcqtrMmKH9+AOy+H2tE3ng3w9EAmYZrzqYuUq6bBw6Z7slm2epCe
         uH9u322ItomcDCaU8FcYCIbF3pERqrSS6KRPTE+rWJ2qkaPkTyQ6DfqBeLxlIcVAjQ
         whRmSl0RtPyi100ru/U3zXY3inNCRS+sQqZiesHNd3yCimktFDLqCERXiGrhyYoT25
         3ZC1PvmfLUT2mYHpiLPFsdr6X8K2rBppKavy7NJc6DlM9WOH7FnhgmcvCC8QxJ7CK8
         Ev+c7I0Jytua3+XQO5/6tKiAklBEcUpl2rvKjqdZ9PBkk5XAp/7xfc9iIepuIDYsuq
         OGijxSaQnzERg==
Message-ID: <ee6598bf-312f-d76d-93e6-16ac7f90b335@collabora.com>
Date:   Mon, 9 Oct 2023 14:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] media: mediatek: vcodec: Handle invalid encoder vsi
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        nicolas.dufresne@collabora.com,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maoguang Meng <maoguang.meng@mediatek.com>
References: <20231007113347.28863-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231007113347.28863-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/10/23 13:33, Irui Wang ha scritto:
> Handle invalid encoder vsi in vpu_enc_init to ensure the encoder
> vsi is valid for future use.
> 
> Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


