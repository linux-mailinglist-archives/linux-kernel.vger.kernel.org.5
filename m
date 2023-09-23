Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A817ABE46
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIWHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:12:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D3199;
        Sat, 23 Sep 2023 00:12:01 -0700 (PDT)
Received: from localhost (unknown [217.144.90.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3B5D735;
        Sat, 23 Sep 2023 07:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3B5D735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695453120; bh=72pEA3GXbiS3uqMqKnTocg5Y9oQReEKN58kbGIZJUW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Bke+ZkTK5HaY2F9koUhyt4tJQUdoTU9pAb7zf1HBLajUfD2OA1WiNKCUHsOXppd6A
         7XqnX2wQZN2ZTKGRRDDwlYq/WPW+YuPNNpiThhrQ0yGvPtGb6gl50Z+JbkIiOYqXHj
         kITnVzDfcFUKeBytBJR8Ryt7Ih+DyC6Mismjhx1rmYqKfFoE/ge9DMR57+c8zTiyJe
         V2CtX8Ld8Rf7udgg4KZ+SQeMU7ABJjG/8sg8yUqILxiyURCDJ5FVpY9/hU7kdo4oHH
         flCM+F0SBKd7Jk3uyLbXeZOnRHMCrMLp6NaOZLWKEqpJXtly49yvD9QMHTxP33c+F4
         vI0DPN3mWhgzQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
        linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH 0/2] Spanish translation of security-bugs and
 embargoed-hardware-issues
In-Reply-To: <20230914174752.3091407-1-avadhut.naik@amd.com>
References: <20230914174752.3091407-1-avadhut.naik@amd.com>
Date:   Sat, 23 Sep 2023 01:11:57 -0600
Message-ID: <87zg1d5poi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avadhut Naik <avadhut.naik@amd.com> writes:

> This patchset translates process/security-bugs and
> process/embargoed-hardware-issues into Spanish
>
> The first patch translates Documentation/process/security-bugs.rst into
> Spanish
>
> The second patch translates Documentation/process/embargoed-hardware-issues.rst
> into Spanish
>
> Avadhut Naik (2):
>   docs/sp_SP: Add translation of process/security-bugs
>   docs/sp_SP: Add translation of process/embargoed-hardware-issues
>
>  .../process/embargoed-hardware-issues.rst     | 341 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   2 +
>  .../sp_SP/process/security-bugs.rst           | 103 ++++++
>  3 files changed, 446 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
>  create mode 100644 Documentation/translations/sp_SP/process/security-bugs.rst

Series applied, thanks.

jon
