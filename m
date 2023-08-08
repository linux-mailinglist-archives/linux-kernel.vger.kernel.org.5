Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2397742D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHHRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjHHRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:50:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C653E93EF;
        Tue,  8 Aug 2023 09:22:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7E8D08176;
        Tue,  8 Aug 2023 10:26:16 +0000 (UTC)
Date:   Tue, 8 Aug 2023 13:26:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: add
 ti,am654-padconf compatible
Message-ID: <20230808102615.GS14799@atomide.com>
References: <20230808102207.130177-1-d-gole@ti.com>
 <20230808102207.130177-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808102207.130177-2-d-gole@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230808 10:24]:
> Add the "ti,am654-padconf" compatible to support the new wakeup enable and
> status bits positions on K3 family SOCs that support the IO daisychain
> feature.

This one too:

Reviewed-by: Tony Lindgren <tony@atomide.com>
