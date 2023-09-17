Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187677A365E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjIQPcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjIQPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:32:13 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF8E67
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1694964602; x=1695223802;
        bh=xCV78BUZ8wWHYIMMcO4tVeNrAYJwIdS9yFfArGxbUqA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SlYa5y0afeSTQ5KzBpULSlj2qXsKFgdjTpp1DG0YPGM4HMdCUYVv4dP0OvGEYP5RA
         yohGBk3IXf1bbJbS9t2hPRn83JJYrRT87gPT/NcU/lJJ48SvJ4PTcU8eCwpWs8XgVS
         XAqtGOtHdI6AEgHp2/DIADoUFw9mhE6Kg5hRZtqGB9eOcz+pKDU2DuZM3OC+ob73nI
         ArOJAmIq2vawDVdTXqzJEGL1hTILJWo0+UU2bREmvch4jsKArc5e6TcELRiw7JCJ/F
         mYkJBtz+a3BNI31VIjzPLTqTZf3rwGOPBarfAy7qdj3deHDavwmi+rhLTRy3LhUOE2
         r9JFxlfirtlBw==
Date:   Sun, 17 Sep 2023 15:29:44 +0000
To:     linux-hams@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, thomas@osterried.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, linux-doc@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 0/3] ax25: Update link for linux-ax25.org
Message-ID: <20230917152938.8231-1-peter@n8pjl.ca>
In-Reply-To: <20230908113907.25053-1-peter@n8pjl.ca>
References: <20230908113907.25053-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

http://linux-ax25.org has been down for nearly a year. Its official
replacement is https://linux-ax25.in-berlin.de.

Update all references to the dead link to its replacement.

As the three touched files are in different areas of the tree, this is
being sent with one patch per file.

Peter Lafreniere (3):
  Documentation: netdev: fix dead link in ax25.rst
  MAINTAINERS: Update link for linux-ax25.org
  ax25: Kconfig: Update link for linux-ax25.org

 Documentation/networking/ax25.rst |  4 ++--
 MAINTAINERS                       |  6 +++---
 net/ax25/Kconfig                  | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

--=20
2.42.0


