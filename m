Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA67D2D66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjJWI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJWI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:56:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4BD6E;
        Mon, 23 Oct 2023 01:56:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1881E66072AE;
        Mon, 23 Oct 2023 09:56:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698051415;
        bh=fXrIYiao92p4xph//uiSgSMTKeoj7373HkQQZccXFC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lsPTP4OmUpuvW0Mesnre8XUjMTVvQc09q13ulhcO4XoaSoI55G2Jgc1O6MBWGjoCA
         rKMSYnKZ91kg/pISTRZb9zCSFyzXgKJNk80XopETsiCeY5CvD66SDT5O9N4Zvvwwr4
         eW2elMJ401xyroOqM78DAuE/ZVu1WbuFKOiahLW+Hir2qrJ2pMl4xiNAkD5bTIauGU
         /dtpzNSGVy6TU4bRveu4RNt5ulNImhQ9CccoahLSQRKZeiXk9RVZwa8zhoRfECB31m
         0oFzVR1zUNiOsUAXFTB+XHkAdi06uPr85+vsvsAEVYEMjnkOYfqAgOKm0dRC2DDW9W
         NPLwlrmS4ZkxA==
Message-ID: <a50a2a08-f2b9-4a6a-9a65-7398b208e7b3@collabora.com>
Date:   Mon, 23 Oct 2023 10:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,3/7] media: mediatek: vcodec: Set the supported h265
 level for each platform
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231023030640.16393-1-yunfei.dong@mediatek.com>
 <20231023030640.16393-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023030640.16393-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 05:06, Yunfei Dong ha scritto:
> Set the maximum H265 codec level for each platform.
> The various mediatek platforms support different levels for decoding, the
> level of the codec limits among others the maximum resolution, bit rate
> and frame rate for the decoder.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

