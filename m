Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835980F7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377285AbjLLUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjLLUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:16:28 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69A98;
        Tue, 12 Dec 2023 12:16:34 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rD9B0-0006LK-2c; Tue, 12 Dec 2023 21:16:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/3] dt-bindings: drm: rockchip: convert inno_hdmi-rockchip.txt to yaml
Date:   Tue, 12 Dec 2023 21:16:18 +0100
Message-Id: <170241214695.534713.7214465445904239057.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 18:39:03 +0100, Johan Jonker wrote:
> Convert inno_hdmi-rockchip.txt to yaml.
> 
> 

Applied, thanks!

[2/3] ARM: dts: rockchip: rk3036: fix hdmi ports node
      commit: 27ded76ef0fcfcf939914532aae575cf23c221b4
[3/3] ARM: dts: rockchip: rk3036-kylin: add hdmi-connector node
      commit: 569b26af7919c15a8ce231b4fae29cfbd811f144

And changed the connector-type to "a" :-)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
