Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F87CC40E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjJQNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJQNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:11:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CABF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:11:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9C1C433C8;
        Tue, 17 Oct 2023 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697548268;
        bh=crP2Q6lKGLJtFT7a6m4r7m8MiXo0QO9LTQxNQRWK3Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvP+rcmUghZEfoEP7vk1vj9ARvr+1YE0fLsJpwGIRirSb8wNlmZMilKjYWXPCW08D
         A8PoGuZV0qtUh8afH9+Og7gX4q8gfRX0upaCSrusNhAbcWYO/Th9kxhN3Unykvgftd
         GhVoTpZbQgiV1c5VXQjgX/HSXZz+r75gnmo9mzyjIwamCpg6QSFoFxjMB9oVTuVdiO
         hrsNu9QfD4bK6qsBLU6O9ImHTAgUT5TZQpoih0j7LpStIRccXm9NmCn0HTZlFQ3isP
         SCd8xWUSWb2ogwhHcKfSmMnVE1rtsQmQibnZ6ri5Kjl92rkIa5trlFWGk+TNms/0CB
         NGe+n5Rt3LViA==
From:   Will Deacon <will@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] perf/amlogic: add missing MODULE_DEVICE_TABLE
Date:   Tue, 17 Oct 2023 14:10:59 +0100
Message-Id: <169754257300.1684180.5817305296970667269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231012103543.3381326-1-m.szyprowski@samsung.com>
References: <CGME20231012103551eucas1p2422c1c7ace26714addeaadde8b645d4b@eucas1p2.samsung.com> <20231012103543.3381326-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 12:35:43 +0200, Marek Szyprowski wrote:
> Add missing MODULE_DEVICE_TABLE macro to let this driver to be
> automatically loaded as module.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/amlogic: add missing MODULE_DEVICE_TABLE
      https://git.kernel.org/will/c/32269e09b137

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
