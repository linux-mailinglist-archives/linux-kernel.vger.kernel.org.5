Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E37B4E58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjJBI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjJBI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:59:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F77AB;
        Mon,  2 Oct 2023 01:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE83C433C7;
        Mon,  2 Oct 2023 08:59:01 +0000 (UTC)
Message-ID: <5b1006ba-37d9-4dbe-ad21-b0bba454e97b@xs4all.nl>
Date:   Mon, 2 Oct 2023 10:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MediaTek MDP3: use devicetree to retrieve SCP
Content-Language: en-US, nl
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        sakari.ailus@linux.intel.com, u.kleine-koenig@pengutronix.de,
        linqiheng@huawei.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 11:59, AngeloGioacchino Del Regno wrote:
> Especially now that Multi-Core SCP support has landed, it makes sense to
> retrieve the SCP handle by using the "mediatek,scp" property (as already
> done in MediaTek VCODEC), both to select one specific SCP core for MDP3
> and to avoid walking the parent node to find a SCP node.
> 
> AngeloGioacchino Del Regno (2):
>   media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
>   media: platform: mtk-mdp3: Use devicetree phandle to retrieve SCP
> 
>  .../bindings/media/mediatek,mdp3-rdma.yaml       |  6 ++++++
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c | 16 ++++++++++------
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 

This series no longer applies to our staging master branch.

Since Krzysztof also asked for a better patch 1/2, I prefer a rebased and
updated v5.

Regards,

	Hans
