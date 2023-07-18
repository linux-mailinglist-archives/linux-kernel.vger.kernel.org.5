Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65375734D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGRFoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGRFoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35010C0;
        Mon, 17 Jul 2023 22:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F9D6134A;
        Tue, 18 Jul 2023 05:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329F3C433C7;
        Tue, 18 Jul 2023 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689659082;
        bh=fMxCFJdsUJm8JBt25eJ62JnVPqBMNzOsIhTVtRXpBFg=;
        h=From:To:Cc:Subject:Date:From;
        b=AeLUpJrvbntC/9V1r8aaaRBAa4dOcdWTTmtDAdmwEnVw1CN4SGsmmtzsLg1CtUszm
         JgYZhV9okcXuAMGW8Zl6MDBxesukgHZNL8SVxX2+5hZ2Yxlcg2x/kQU8Tqbpz7wO+L
         K2nv6XjXC/4cGG3Dqq/vyq2OK1Q3xWy6ItFleXN4gNa+2OvJ4YR9cOuiuNqPZelo1i
         uC/2QiD37dwh6X8zeH+WSaYEvFUpXFO4ADEVJVbtvYR5BJQmxGoXZQguKIpx4MRCqU
         nHu31sVaSq89Nrjdr5StYvTDycYQJHMbN1vqi9zwRP+GaaviRQSCE0pbE5lCgndorw
         Wp9NNcGKcav7w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] MAINTAINERS: add Andreas Hindborg as Rust reviewer
Date:   Tue, 18 Jul 2023 07:44:25 +0200
Message-ID: <20230718054426.1048583-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas has been involved with the Rust for Linux project for more than
a year now. He has been primarily working on the Rust NVMe driver [1],
presenting it in several places (such as LPC [2][3] and Kangrejos [4]).

In addition, he recently submitted the Rust null block driver [5] and
has been reviewing patches in the mailing list for some months.

Thus add him to the `RUST` entry as reviewer.

Link: https://rust-for-linux.com/nvme-driver [1]
Link: https://lpc.events/event/16/contributions/1180/attachments/1017/1961/deck.pdf [2]
Link: https://www.youtube.com/watch?v=BwywU1MqW38 [3]
Link: https://kangrejos.com/A%20Linux%20(PCI)%20NVMe%20Driver%20in%20Rust.pdf [4]
Link: https://lore.kernel.org/rust-for-linux/20230503090708.2524310-1-nmi@metaspace.dk/ [5]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..f2f0426258f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18542,6 +18542,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
 R:	Benno Lossin <benno.lossin@proton.me>
+R:	Andreas Hindborg <a.hindborg@samsung.com>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://github.com/Rust-for-Linux/linux

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

