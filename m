Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59E7653B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjG0MYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjG0MXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C843A80;
        Thu, 27 Jul 2023 05:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90DC61E52;
        Thu, 27 Jul 2023 12:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1890BC433C8;
        Thu, 27 Jul 2023 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460589;
        bh=qZPERE2RDosFUBDz6Q2hK9hpeZUjAWF47lxikhbbT8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g70orOrK/LWt5BrNzCSeK9llYB8XnH/4b8hjF8/5wMuQZ2a7D2nnWiBtR/kPqYsH6
         dJ2rDCELS1LTqsaepvq+juPfytHqQTrEH6S7h2l1JEEXpxMZcE4MNwlqEtxBaPnlds
         65v6RfwOOCC4r9pWsJYfODyXqDCzWRfqr1qpAlOi1uGKMrl3dgmt9fR4msTjvp3vrv
         U3B+g7CTf/Cz/MLhx/r9FinXADcJ40faXOaVlKy+zqpmJJNZFJQj3+O1jdDojHVYoE
         zj1MMe2RimiWZTY7b+sVbbmMYeSt3U0O4wqZ/Sl1rJQgBFLUnkWf/F91scy6TIg+EA
         S+CMw62Xi1xXA==
From:   Will Deacon <will@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: pmu: Add Cortex A520, A715, A720, X3, and X4
Date:   Thu, 27 Jul 2023 13:22:36 +0100
Message-Id: <169045928040.3249102.16164791784364079619.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230706205505.308523-1-robh@kernel.org>
References: <20230706205505.308523-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 14:55:03 -0600, Rob Herring wrote:
> Add compatible strings for the Arm Cortex-A520, Cortex-A715,
> Cortex-A720, Cortex-X3, and Cortex-X4 CPU PMUs.
> 
> 

Applied to will (for-next/perf), thanks!

[1/2] dt-bindings: arm: pmu: Add Cortex A520, A715, A720, X3, and X4
      https://git.kernel.org/will/c/039768b55853
[2/2] perf: pmuv3: Add Cortex A520, A715, A720, X3 and X4 PMUs
      https://git.kernel.org/will/c/989567fc0f3d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
