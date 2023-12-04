Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5D8031B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjLDLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjLDLnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:43:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F87BB;
        Mon,  4 Dec 2023 03:43:29 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F4D866022D1;
        Mon,  4 Dec 2023 11:43:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701690208;
        bh=4/mLg+jbxiWpmg5kaUHJzIz8SeJLCb9j392/hDq409k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jYdSvrDKYgKcvvp9hg1ZcaGvctutpiWr+LUtpUQrt4ByDsgGYGLLBU7nR36h45R95
         uH5NDUZFLW6ueHxR0djUBnZgP2+NyOW+bLpCXXjO7AaDJiPYdiEQRSGda/wS3C7lfP
         huGdmuxzhw7v5bIrlF4AFYUaosx2w3JmoCQUFpBln/9bbVhFss6DTltknZhfoWWyH1
         YjQNKwfE3APk+NBxwbgTAMScf96UUlWYajAjCJLqLgITZxvfMNjUEKN+KtgESh1k0r
         Z+4TryXltO90QN7sqp5pjo9P0vNMDJSFKTmXLB8JEQVlNhq6iZiNIEsOWLXo1996Rp
         DKHQ0VGerCl/g==
Message-ID: <73a0847d-09e0-4587-bd76-164b2b4d8aa7@collabora.com>
Date:   Mon, 4 Dec 2023 12:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: mtk-sd: Increase the verbosity of
 msdc_track_cmd_data
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ot_shunxi.zhang@mediatek.corp-partner.google.com,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, linux-mmc@vger.kernel.org
References: <20231201102747.3854573-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231201102747.3854573-1-treapking@chromium.org>
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

Il 01/12/23 11:26, Pin-yen Lin ha scritto:
> This log message is necessary for debugging, so enable it by default to
> debug issues that are hard to reproduce locally.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


