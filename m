Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E575E48F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGWTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGWTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:32:56 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 12:32:55 PDT
Received: from mellowmood.mkp.net (mellowmood.mkp.net [104.200.29.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19094;
        Sun, 23 Jul 2023 12:32:55 -0700 (PDT)
Received: from mellowmood.mkp.net (localhost [127.0.0.1])
        by mellowmood.mkp.net (Postfix) with ESMTP id 7D5D0BA3;
        Sun, 23 Jul 2023 15:12:51 -0400 (EDT)
To:     Udit Kumar <u-kumar1@ti.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <=martin.petersen@oracle.com>, <jejb@linux.ibm.com>, <nm@ti.com>,
        <vigneshr@ti.com>
Subject: Re: [PATCH] scsi: ufs: TI UFS host controller expose device tree
 aliases
From:   "Martin K. Petersen" <=martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz0i787n.fsf@ca-mkp.ca.oracle.com>
References: <20230710094801.183149-1-u-kumar1@ti.com>
Date:   Sun, 23 Jul 2023 15:12:51 -0400
In-Reply-To: <20230710094801.183149-1-u-kumar1@ti.com> (Udit Kumar's message
        of "Mon, 10 Jul 2023 15:18:01 +0530")
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Udit,

> When TI UFS host controller driver is built as kernel module,
> It was not getting auto loaded due to missing aliases in modules.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
