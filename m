Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF667F65C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjKWRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:47:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6511F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:47:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB9C433C7;
        Thu, 23 Nov 2023 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761654;
        bh=G6fzjX1GbRtb7Su9/jaitT87KthKO3fzQSb2k71GPoA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eGlA4O2miieWtiZgXDBCsk5FOyFJaf9z8PdL+HpdA4DMbjbpfJOUjjzANl1GvM9Ul
         0TDU61cxEBC/fd7+UGv4gpl1cQRf7+kHVBnW+5amyB+/xRg73o10mMMoc25gbLNLZn
         AxQwI7isHtpIEXRBl3ywn8tU2v/bqfl9QSSBVprRkBTStsC2RsMIuzVVIzWx4WyBWH
         71ixs7aFWhJpUIDq/u22E1uu/l8FSkaLfS5pde3BOYaArBeGJr4RhJRlN8PaDPPAad
         UdzNhAwXTq+Jhr2wnDY6oPS0NyxSR8SR7G7MVMn6j7nAYEedN8fZGDOiGShOlrlB5u
         KQ1ecGkOiqLNA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20231123132803.1107174-1-naresh.solanki@9elements.com>
References: <20231123132803.1107174-1-naresh.solanki@9elements.com>
Subject: Re: (subset) [PATCH v5] leds: max5970: Add support for max5970
Message-Id: <170076165290.1472423.16438293680293948844.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:47:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:28:02 +0000, Naresh Solanki wrote:
> The MAX5970 is hot swap controller and has 4 indication LED.
> 
> 

Applied, thanks!

[1/1] leds: max5970: Add support for max5970
      commit: 8171710be2d04fdc263da49212d7b875d3688f58

--
Lee Jones [李琼斯]

