Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05737FC8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjK1Vmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Vmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:42:38 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819894;
        Tue, 28 Nov 2023 13:42:44 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     dan@danm.net
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        toralf.foerster@gmx.de, linux-hardening@vger.kernel.org
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference,
 address: 0000000000000020
In-Reply-To: <20231128213018.6896-1-dan@danm.net>
Date:   Tue, 28 Nov 2023 21:42:03 +0000
Organization: Gentoo
Message-ID: <87jzq1lflc.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect this is https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
and the patch at
https://lore.kernel.org/linux-hardening/170117162434.28731.12930304842635897908.git-patchwork-notify@kernel.org/T/#t
may help.
