Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F597B1009
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjI1AaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1AaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068FBF;
        Wed, 27 Sep 2023 17:30:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B0FC433CB;
        Thu, 28 Sep 2023 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861003;
        bh=bMT9IxhC+TNBsZCKniLy1v2Qfy6SFvVS8eBjXCrZ3BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvA+oy0tl44XIOyXLhCwdasZIY8+R/RFvsM2YCWymp4MhJDBJ3QL0yYAHK7pApCrl
         KHJYURAXxaz9D/JNABijsONbhSXSfD6jHrFAX6nnobRN2jOgiSMaq+qqu96EUF4qzg
         lwhiGs1aH8RQ93+JsW/3Fc12rRiXPQo6puQm9QXnxGEVYMmHTd6f5gw+nIxvYyKQvb
         7k9AhFHO9V7/TIa9slJAqI+TxpYP5z0NcGSu3xI+ADQWSo6GbS7ZUJ/V8ScvQ8TG+r
         o+km8BWuNckna4saUxEBftiElcY+v8WyIlMvKJjjj+dnfErA+miwCftkbGPZCdTNqh
         Hds7TEdZIR9BA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add rpm-master-stats nodes for MSM8226 and MSM8974
Date:   Wed, 27 Sep 2023 17:34:07 -0700
Message-ID: <169586125032.1226038.15416891451357190920.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922003533.107835-1-matti.lehtimaki@gmail.com>
References: <20230922003533.107835-1-matti.lehtimaki@gmail.com>
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


On Fri, 22 Sep 2023 03:35:31 +0300, Matti Lehtimäki wrote:
> Add rpm-master-stats nodes and the required RPM MSG RAM slices
> for MSM8226 and MSM8974.
> 
> Matti Lehtimäki (2):
>   ARM: qcom: msm8226: Add rpm-master-stats node
>   ARM: qcom: msm8974: Add rpm-master-stats node
> 
> [...]

Applied, thanks!

[1/2] ARM: qcom: msm8226: Add rpm-master-stats node
      commit: bd837be0ff3879209df6fb85cf9e22fd1ba7f79b
[2/2] ARM: qcom: msm8974: Add rpm-master-stats node
      commit: 02c58ac774a03ffefd3708f9c17ea4d911e0ade7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
