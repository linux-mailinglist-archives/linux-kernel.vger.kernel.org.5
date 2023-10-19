Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A47CF910
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjJSMfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbjJSMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:35:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2991
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:35:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE5C433C8;
        Thu, 19 Oct 2023 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718914;
        bh=2YLoh1AhLgqblg+Pm4CDbBvQjzutTIMWE2G2WOryXoo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r2krpKJY8PaWx5skYfmkwp5VczrVbY95CnTUOPLHkOsPJ/wsx1+OMZdwdXMFicFTp
         mte5KCd687kqMslg8ACt3UgVf8JqzCTHAa3OCRaTmoOxTMNvHGhf8X/k05wVdIxuPd
         LCDQm/TGrrI2Evp4n+bEjqtLjSs53t5NcKY9dj/SDKs9JmMO7FPhDJcWml1bSSWhdg
         L8V9RHzuuhlMN1gP4n1/YEcVqxfTsq9250saw1XvHOwp+v+XtwA8j6zcd3O2+BKsyg
         5y8+qA42jxMKJaPcWMZZYVS2DMpa4D1VYvxdEEojlgBFS84ht/zgroTwKK/BadY4J9
         N9NEOpYQHeSJA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20231017203550.2700601-1-robh@kernel.org>
References: <20231017203550.2700601-1-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH] mfd: Use spi_get_device_match_data()
Message-Id: <169771891326.2476679.10942704861321652608.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:35:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 15:35:49 -0500, Rob Herring wrote:
> Use preferred spi_get_device_match_data() instead of of_match_device() and
> spi_get_device_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> 

Applied, thanks!

[1/1] mfd: Use spi_get_device_match_data()
      commit: d3119e4b7fa704ad0660a256a4666984bb6ae831

--
Lee Jones [李琼斯]

