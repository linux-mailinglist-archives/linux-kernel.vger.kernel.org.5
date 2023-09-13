Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6139579F2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjIMUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:38:03 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518431BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:37:59 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id DD2281405AD;
        Wed, 13 Sep 2023 20:37:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id D896C2000E;
        Wed, 13 Sep 2023 20:37:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] checkpatch: refactor and add new alloc w/ multiply tests
Date:   Wed, 13 Sep 2023 13:37:50 -0700
Message-ID: <cover.1694636817.git.joe@perches.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D896C2000E
X-Spam-Status: No, score=4.27
X-Rspamd-Server: rspamout06
X-Stat-Signature: d7tctd4x89k9ykppmdk9634par3hybbg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+pItHLPP733JzO0vTAWKOf20Uqe7XRG5Y=
X-HE-Tag: 1694637475-542934
X-HE-Meta: U2FsdGVkX19l2ByWlrCVwERjE7c03aBPW442dM3QLRNru3I0cpxeQ2mbIURAGvbKdgJS+Mjr6dnageWp/plKeK4FPiue97VNuxgcVtWBOPpTQclKLQvDbXqYgKk1LCpzG+KnkA+AP4TTFeTj5VH9aulJRsIEuZEQtuxFCB2KPtkkZRAeJHTYcgjFKUSVXhlnXyIvgobe0YREmcFFzG4Uq/lIo6zGIxs/yti8oRlI/GefifGcKWDbTxR/7WdLDUDlkm+ZLEU9XyANaumrrovQEYtiJCVS8VrN+6lbIQ0JR9E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original alloc function patch by Gustavo Silva

Joe Perches (2):
  checkpatch: Simplify creating search strings
  checkpatch: Add a couple new alloc functions to alloc with multiplies check

 scripts/checkpatch.pl | 55 +++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

-- 
2.41.0

