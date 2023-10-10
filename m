Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2F7C0208
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjJJQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJJQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:54:30 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC28E;
        Tue, 10 Oct 2023 09:54:25 -0700 (PDT)
Received: from i53875b94.versanet.de ([83.135.91.148] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qqFzp-0006F2-Mf; Tue, 10 Oct 2023 18:54:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     quentin.schulz@theobroma-systems.com
Cc:     Heiko Stuebner <heiko@sntech.de>, thierry.reding@gmail.com,
        airlied@linux.ie, sam@ravnborg.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <foss+kernel@0leil.net>, daniel@ffwll.ch
Subject: Re: [PATCH 1/3] drm/panel: ltk050h3146w: add mipi_dsi_device.mode_flags to of_match_data
Date:   Tue, 10 Oct 2023 18:54:11 +0200
Message-Id: <169695678310.350877.5388571923561270631.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
References: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 17:47:21 +0100, quentin.schulz@theobroma-systems.com wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> To prepare for a new display to be supported by this driver which has a
> slightly different set of DSI mode related flags, let's move the
> currently hardcoded mode flags to the .data field of of_device_id
> structure.
> 
> [...]

Applied, thanks!

[1/3] drm/panel: ltk050h3146w: add mipi_dsi_device.mode_flags to of_match_data
      commit: 99403d747ae8c7b3bfb5cd14c8908930ec6801c6
[2/3] drm/panel: ltk050h3146w: add support for Leadtek LTK050H3148W-CTA6 variant
      commit: e5f9d543419c78ac58f3b3557bc5a76b20ff600b
[3/3] dt-bindings: ltk050h3146w: add compatible for LTK050H3148W-CTA6 variant
      commit: 29d8e38c36cb662331a833699c359ec1af1edbec

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
