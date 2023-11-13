Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412C7E9F65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjKMO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKMO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:59:35 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6679D44;
        Mon, 13 Nov 2023 06:59:30 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3BB751F8F7;
        Mon, 13 Nov 2023 15:59:26 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] usb: misc: onboard-hub: add support for Microchip USB5744
Date:   Mon, 13 Nov 2023 15:59:19 +0100
Message-Id: <20231113145921.30104-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.

Stefan Eichenberger (2):
  dt-bindings: usb: microchip,usb5744: Add second supply
  usb: misc: onboard-hub: add support for Microchip USB5744

 .../devicetree/bindings/usb/microchip,usb5744.yaml         | 7 ++++++-
 drivers/usb/misc/onboard_usb_hub.c                         | 2 ++
 drivers/usb/misc/onboard_usb_hub.h                         | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.25.1

