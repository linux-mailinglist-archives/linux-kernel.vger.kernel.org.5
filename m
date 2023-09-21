Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA787A967D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIURGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIURGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:06:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED746A0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:04:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C98C4E74F;
        Thu, 21 Sep 2023 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306574;
        bh=4bbc4KFxteB/Ul25CGRhUsPNrRkXu49opVZPwgJoYRY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cO+X4/GgnHxtTIggHp57WsfT0grOdhO6tbul7FG+POvV+KkKMnzn59Ghk2DDzlZtL
         AOCYZgeQJHjgzhx/GHpmddYZMcNvn/+VoEzRKEXOewRvhCya7ZG59a57WowOPeNXbt
         9W2/8adcznrGqEebf/rqhYimiuJAI4HuqQDKUoD8yTTneBDYPT6rXIKTBiy7ZcMGs4
         dfTPPZh5CC04+Xmx1f998CZcT5Ju5Drjze0UB/Ny7DRJesqfkcVeQo8/Z6YHdTpNa+
         OHGaOf1IpdzEQlenymzCNjT8xxYtquBD5140sNSSbrTTUIL3nO01q9VgpvFGKwEEUT
         oB01lwrxnHE8g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230823132224.111326-1-rgallaispou@gmail.com>
References: <20230823132224.111326-1-rgallaispou@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: phy: st: convert phy-stih407-usb to DT
 schema
Message-Id: <169530657238.106263.8150878577535547665.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 15:22:24 +0200, Raphael Gallais-Pou wrote:
> Convert the st,stih407-usb2-phy binding to DT schema format.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: st: convert phy-stih407-usb to DT schema
      commit: d61644df75d07863386e0a66fc7306de8b6c5fb0

Best regards,
-- 
~Vinod


