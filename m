Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EF7D8379
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbjJZN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJZN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:26:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A58E5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:26:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E9C433C8;
        Thu, 26 Oct 2023 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698326776;
        bh=EkEQs9N23jDDNdbmrMAfm/n0wa1XEFhc3nFLxMLQBfk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=phCC8uNydBc6FI51+5GxUnplh0W6pHKM/k1kCBdgKGdSLVRB25tPZzMSM5b9CSEi6
         NnDL+8L6rdKgTWVvBT/NBBIj0EfltwYqA99WgClIVDgnKFQTa5pKv5sHghnpJ6iH2L
         a1Dz1GENta9hCJTNryRzvDwV+Ex5MzGGjK22BdAgwJwpcbcrXqx+zZ2otAAu/7NPZe
         y1m71EsEfiDdLlwmTX0xT8jkN/b+wKmE7vvRFfWoJIgWZ2xPFy7gBBBGAqFAEw8MkG
         rKx97y13DM1ZB7pbH/QFsTr7zFLVbyFrDGPF9dKYp0U4R2ckI7QXWHf+yEJ8U2aqn9
         uWfObGYv/9nUg==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, david.heidelberg@collabora.com,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        daniels@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20231024004525.169002-1-helen.koike@collabora.com>
References: <20231024004525.169002-1-helen.koike@collabora.com>
Subject: Re: [PATCH v3 00/10] drm/ci: fixes and improvements
Message-Id: <169832677439.958223.17998130799046222765.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 15:26:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 21:45:15 -0300, Helen Koike wrote:
> This series contains the several fixes, making drm/ci much
> more reliable and useful.
> 
> Highlights:
> 
> * Current DRM/CI in drm-misc is broken, this series fixes it with mesa
>   uprev (commit 1/9).
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

