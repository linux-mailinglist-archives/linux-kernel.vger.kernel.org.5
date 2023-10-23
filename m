Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82107D2A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjJWG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJWG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:29:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4DDF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:29:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383BAC433C8;
        Mon, 23 Oct 2023 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698042556;
        bh=l0up1LuqtFZ9SiR7cVLTObMPbxT4qYaR/klMHz9+F7M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BNUBrgQHQCjkqBnNxsrPe3n4/Adbshw09kUJVBlCvEMfoZHDbbgMAJlGC5vPkoRTe
         Ps9D53sQ0pjAh99PntOvE1rPDcdGaLpMeoc71pR8gmvFtiMAkzGxtg+h5b7dOLmuVn
         yXluBuS5GG8w2cKpUGzgCGs9joIcEoXE46qM7s1VyamazLu5qqLrbmYPru7Kngu2kU
         PyN6iAQrsRgYqe9jWblOiPDodhHDFEYBZ1aCr4cdsYjusabT8P3O5qtsUx8JkHIBEC
         22Fl6n2qt6QgyEeW3azm5biTa7tgsJhMzJxI9F9zgSz4xTXp7ups9OvA/Tj5hz51u4
         q4LyWKDIPwQkw==
From:   Vinod Koul <vkoul@kernel.org>
To:     kishon@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231017031635.105993-1-yang.lee@linux.alibaba.com>
References: <20231017031635.105993-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] phy: Remove duplicated include in
 phy-ralink-usb.c
Message-Id: <169804255380.383714.12352932455695541370.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 11:59:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 11:16:35 +0800, Yang Li wrote:
> ./drivers/phy/ralink/phy-ralink-usb.c: linux/platform_device.h is included more than once.
> 
> 

Applied, thanks!

[1/1] phy: Remove duplicated include in phy-ralink-usb.c
      commit: d688c8264b8ed25edbdafac46ea2b41b2e77416a

Best regards,
-- 
~Vinod


