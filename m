Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7042977280F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjHGOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHGOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:43:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7700710F6;
        Mon,  7 Aug 2023 07:43:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9B208809D;
        Mon,  7 Aug 2023 14:43:24 +0000 (UTC)
Date:   Mon, 7 Aug 2023 17:43:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: pinctrl-single: add am62x
 compatible
Message-ID: <20230807144323.GP14799@atomide.com>
References: <20230803092311.604610-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803092311.604610-1-d-gole@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230803 09:24]:
> Add the am62x compatible property to add support for the new
> wakeup enable and status bits positions
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Tony Lindgren <tony@atomide.com>
