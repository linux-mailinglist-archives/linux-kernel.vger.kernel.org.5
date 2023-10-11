Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336527C551C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjJKNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJKNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:18:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C68F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:18:31 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 473286607313;
        Wed, 11 Oct 2023 14:18:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697030309;
        bh=PAWJ3RzsuekP+W3e6be5gu5BDgIjN+40d2Z1bOG28aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPvcE8vDi5SergJ5DzBmpack84PQy7dQDKtxEd2SCcfL77jG4RrgQOdH1sygHooze
         vciWjN7skA2MOP3cAIZKTPh46lXKu288QpmuJ3TKB+YsufBrgGF4QeU70mzYOMqHRL
         Lt000mqJG+scMo3dNKbLNJcUTVQmijMAKIARXR0hmzudkHPaAHhoLMjVswHMiKIttu
         EsM6yUdDfQoBzi+hDz7mmW4zGmHugfAvvaOHPzQpTk16jeaWhKMvYnu8QrkolTaHx2
         UV1CWymdfAaHSnWsNSIYupvQUpAeQlGqeaqudirzDcKapgJgtqZe4z4qzSFkWnvVZQ
         sgJ3ciG5ImaAQ==
Date:   Wed, 11 Oct 2023 09:18:23 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: Re: [PATCH v10 07/16] drm/mediatek: aal: Use bitfield macros
Message-ID: <4fbfc898-b13c-4cf0-9a2a-308e37838dd8@notapiano>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
 <20230804072850.89365-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804072850.89365-8-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:28:41AM +0200, AngeloGioacchino Del Regno wrote:
> Make the code more robust and improve readability by using bitfield
> macros instead of open coding bit operations.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
