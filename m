Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBD77FBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353584AbjHQQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353587AbjHQQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:20:09 -0400
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net (p3plsmtpa08-06.prod.phx3.secureserver.net [173.201.193.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25148173F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:20:08 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id WfjBqlb9Zd24CWfjDqKzOE; Thu, 17 Aug 2023 09:20:07 -0700
X-CMAE-Analysis: v=2.4 cv=ZIQR213b c=1 sm=1 tr=0 ts=64de48b7
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=sHM7qeaOCMdHV3KOwg8A:9
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH v2 1/1] workqueue: Rename rescuer kworker
Date:   Thu, 17 Aug 2023 17:20:05 +0100
Message-Id: <20230817162005.2284847-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZNrFOf0wWbJavaUV@slm.duckdns.org>
References: <ZNrFOf0wWbJavaUV@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMMnn5Uqt9FEA/vr9SPb5zM5Ww7kJGwWWvttQCy5UWY9M2oKeUxBGd2sWEvTNuM/dQdRohUfLsMjzRBHEeM8WgBpEdoJO12Aj0/kdFKsXq0R7Yn7ZVQt
 EO4QCY8l5c3JNO3rSNmg+3GuGmgtx82NPRhNzCyx9dKEKKNcDUgn722ypAGf4oWO3SHem+eU46cQIQY+AKMnl0pIn1TFONzELo6muRkvqfHWJeGvqbGe2Hq6
 WNpZg5pHTvo8RLtCBklQeRpCBr/bBp0tvxCMe8NAHxfhkyvsedFaIM6/4/+h/fq3t5uwdL9igsopXvdPdp5i7A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied to wq/for-6.6 with prefix "r" replaced with "R" to make it more
> distinct and consistent with how highpri pools are marked.

Hi Tejun,

Thank you.


Kind regards,
-- 
Aaron Tomlin
