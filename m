Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22280F43B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjLLRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjLLRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:16:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A51A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:16:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35104C433C8;
        Tue, 12 Dec 2023 17:16:44 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:16:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 2/4] arm64: mte: add a test for MTE tags compression
Message-ID: <ZXiVedYRiJ3aH6IW@arm.com>
References: <20231113105234.32058-1-glider@google.com>
 <20231113105234.32058-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113105234.32058-3-glider@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:52:31AM +0100, Alexander Potapenko wrote:
> Ensure that tag sequences containing alternating values are compressed
> to buffers of expected size and correctly decompressed afterwards.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
