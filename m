Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4E7E4164
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjKGOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjKGODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:03:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1D10EB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:55:08 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D88066074CE;
        Tue,  7 Nov 2023 13:55:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699365307;
        bh=lEovXn58/a4qnfn12fKn636CmpY/k7Bme8lkfOulb/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b3cY5YwBIxpK4sAvXA6iiM2EDfd+5tG/YQQgKjaRzy6Q2pPcZo+fL2kgLsimWGfzh
         ChwLHWADVMWoPM9DBcoGGkynvuiJt+qmzXGUwPA74HFfctyEtdH5ZcZfKEDne/hv/5
         oTSZJ9ogffTuXH9OkMCvrjlGyjCYUn/DIEEYvdkONqf0+idjbq32qrPF66yqGMciBE
         3eaJ/gZFZbXfY80AAXV7/Md2iyD+CR7zBA9eXnFsxi+BzA7NOwgArqE5vlrq9T/y+8
         fPR3wxQ9OC04v/+792yj0/jjK9r8Ne5WRduqQJHOYjDKkOHFW7uCNRTxjpiQt2z37/
         bhojXkVF5oMQA==
Message-ID: <534c55c3-d045-4c0b-a374-431ac0fe4751@collabora.com>
Date:   Tue, 7 Nov 2023 14:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: SOF: mediatek: remove unused variables
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
Cc:     yc.hung@mediatek.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231103095433.10475-1-trevor.wu@mediatek.com>
 <20231103095433.10475-4-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103095433.10475-4-trevor.wu@mediatek.com>
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

Il 03/11/23 10:54, Trevor Wu ha scritto:
> To prevent confusion on the follow-up platform, it is necessary to
> remove any unused variables within the struct mtk_adsp_chip_info.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


