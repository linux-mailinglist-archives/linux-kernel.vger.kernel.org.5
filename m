Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8336786395
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbjHWWtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjHWWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218DA8;
        Wed, 23 Aug 2023 15:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B61B4639D7;
        Wed, 23 Aug 2023 22:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B5DC433C8;
        Wed, 23 Aug 2023 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692830934;
        bh=122bP+1IAvPtCt9l2arHHkdgiuVehog6Q4WACiIvQyQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E93yULy3fx7OBNAzMxUJWJPd6ov3MmAckXF75LEaxyrhqr0ElFeLf5nD84tUwQBBW
         jMKlyZgLluayS1LoLEoewspXRXGwhfrb/83ixnwW10Pu/v3E7qnghlaBjC7CY6fqxg
         wDNV6c+86gb7AAdXdtHCwUI71b9ABqvN4qS8n75zOjowbbJmyvF0PqoUjsfoN3cwJc
         hfTM7mUhaffw0eIdYZJR6q093Q3q/78JwcrIn4oA5rtSISx/9/Q/FTdDb0XV/gq7tu
         QGNfrHBpZbnGI7o5J39djJZKIJPBAqiP4AdJVtA9HMb+AlkzzBJdzv/5Si6z72lbN9
         4CJPIJkTV8ftg==
Message-ID: <f80114fb033d9ea2ffff93f89d2cfb9f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230802064100.15793-3-mike.looijmans@topic.nl>
References: <20230802064100.15793-1-mike.looijmans@topic.nl> <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ec2b609-3eb5-4de3-93d2-a352a16683c8@emailsignatures365.codetwo.com> <20230802064100.15793-3-mike.looijmans@topic.nl>
Subject: Re: [PATCH 3/3] clk: lmk04832: Support using PLL1_LD as SPI readback pin
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Wed, 23 Aug 2023 15:48:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2023-08-01 23:41:00)
> The PLL1_PD pin (a.k.a. STATUS_LD1) can be used as SPI readback pin. Make
> this possible.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next
