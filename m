Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7D766B88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjG1LQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjG1LP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585DA10FC;
        Fri, 28 Jul 2023 04:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB46D620F9;
        Fri, 28 Jul 2023 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51377C433C7;
        Fri, 28 Jul 2023 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690542956;
        bh=PyjP3f+9n31jt+0umASnjiOR5uaUistYcsi/8tErtnc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AL4uWCfq7psiR7Q1q/6e6RYblllNHpbpHFJVHUydQwjpU1hdIrf22MSGjYDrvA8xz
         3DlpVraKInnVgdjXPUNqC4ze62jgBc1LdgHGgmgElE5b0+QDh872hijGtlz0wQQeJX
         G+SoIqMnA9rezSwaRvgrnXJYvqDqjMpdYEm+xmhRfZhcLwS8f7memAiQ8wHgWgFnJo
         KQvYYGjVPR08I+RCjVZK2FDhy6l/MieP/K/gwwEfNC/gt5cFPksznsZiDzKoKMD1EI
         GxRqVtpt0gaswH662hD1Gjr01tNKY87jS8W8sqVvuY9NgC0+e/x50EriCfF83x+gKY
         lF/NipaRAddZg==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>, Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724230258.1017258-1-robh@kernel.org>
References: <20230724230258.1017258-1-robh@kernel.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: leds: Convert Panasonic
 AN30259A to DT schema
Message-Id: <169054295404.346923.17511363398089527190.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 12:15:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 17:02:58 -0600, Rob Herring wrote:
> Convert the Panasonic AN30259A 3-channel LED controller binding to DT
> schema format.
> 
> 

Applied, thanks!

[1/1] dt-bindings: leds: Convert Panasonic AN30259A to DT schema
      commit: 02a3fa1edeb4fa7bac2cc7f604adf23e34cb2e40

--
Lee Jones [李琼斯]

