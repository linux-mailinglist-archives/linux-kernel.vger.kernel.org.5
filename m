Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636A7A89DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjITQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:58:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3A99;
        Wed, 20 Sep 2023 09:58:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9ACC433C8;
        Wed, 20 Sep 2023 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229103;
        bh=NkzhFjKou/RnvV0T9JyYqksnCrQ9k/JO/XAlDTFE8h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuQjdcQQ896wg91vT4h3+0DR8sXcYdW/CXZBfDTNBBc7Nxi7y0FN8Qt7K1Fr0vB2z
         4xzQKOcqAajLlrXUiVjaGlNWzW1QbO6ISca4cNk7L49DTfKtMYqRVIF6cgY3QoV4R3
         cZ6+DlJwiFsxrJrNc2QdRtLVEUfOGd0f+JtPVcgwEyI8VOuAGHu9kbNZAEeZXNbonv
         A140se8G6GCdBwWb3xgdbikKiuKj6T4fXTGwh3a0/T+YHD0E+X/JdNWANgSG6h23ua
         GRt40Kfih9ajpTUrqMmQiGa0o2AmzQCkj2vUvwmULKA05hNJYoVfKfdPsVxZC55Nsv
         jG6YNkmbNnmvQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v2] dt-bindings: remoteproc: pru: Add Interrupt property
Date:   Wed, 20 Sep 2023 10:02:26 -0700
Message-ID: <169522934569.2501390.13365925421502228955.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230814095141.3526684-1-danishanwar@ti.com>
References: <20230814095141.3526684-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 15:21:41 +0530, MD Danish Anwar wrote:
> Add interrupts and interrupt-names protperties for PRU and RTU cores.
> 
> 

Applied, thanks!

[1/1] dt-bindings: remoteproc: pru: Add Interrupt property
      commit: d93f191b95bec3c913978eb18c6297e797915993

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
