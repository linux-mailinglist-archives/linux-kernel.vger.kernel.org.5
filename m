Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033DC75E418
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGWRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWRrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:47:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB00180
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:47:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qNdAs-0002UF-7X; Sun, 23 Jul 2023 19:47:18 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-07-23]
Date:   Sun, 23 Jul 2023 17:47:17 +0000
Message-Id: <169013434330.3594767.429224047854988999@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690134440;76c4859c;
X-HE-SMSGID: 1qNdAs-0002UF-7X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report from by side; there are a few
regressions I'm aware off, but everything currently is business as
usual. I in the next few days will prod those regressions that
have not progressed in the past week to see what's up there.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 12 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.4.. aka v6.5-rc), culprit identified
======================================================


[ *NEW* ] PCI: acpiphp: Oops on first attempt to suspend, freeze on second
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/
https://lore.kernel.org/lkml/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/

By Woody Suwalski; 3 days ago; 4 activities, latest 0 days ago.
Introduced in 40613da52b13 (v6.5-rc1)

Fix incoming:
* Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=7ece3fae5ff0d1e2d947580f922a16492f0ddd81


[ *NEW* ] drm: amdgpu: HW acceleration broke on ThinkPad E595
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/
https://lore.kernel.org/amd-gfx/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/

By Michel Dänzer; 6 days ago; 4 activities, latest 2 days ago.
Introduced in 84b4dd3f84d (v6.5-rc1)

Recent activities from: Michel Dänzer (4)


[ *NEW* ] powerpc/64s: Crash Dump (kdump) broken with 6.5
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/AB3C7C5C-86FD-4D86-9330-000CB9728F48@linux.ibm.com/
https://lore.kernel.org/linuxppc-dev/AB3C7C5C-86FD-4D86-9330-000CB9728F48@linux.ibm.com/

By Sachin Sant; 6 days ago; 7 activities, latest 2 days ago.
Introduced in 606787fed726 (v6.5-rc1)

Recent activities from: kernel test robot (2), Sachin Sant (2), Mahesh J
  Salgaonkar (2), Michael Ellerman (1)

One patch associated with this regression:
* Re: Kernel Crash Dump (kdump) broken with 6.5
  https://lore.kernel.org/linuxppc-dev/2ogfzwjumrd44kxv7njfpot6fhtkzpqu77qv3bspfixdmsxcwc@umt35y2hmslm/
  3 days ago, by Mahesh J Salgaonkar


KVM: arm64: boot failures due to missing bti instructions
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230704134136.a5znw4jupt5yp5kg@bogus/
https://lore.kernel.org/lkml/20230704134136.a5znw4jupt5yp5kg@bogus/

By Sudeep Holla; 19 days ago; 19 activities, latest 6 days ago.
Introduced in b53d4a272349 (v6.5-rc1)

Fix incoming:
* KVM: arm64: Add missing BTI instructions
  https://lore.kernel.org/lkml/55bffc21-5f19-765f-9dbc-1b565c880426@leemhuis.info/


CONFIG_EFI_PGT_DUMP regression due to allowing failing pte_offset_map[_lock]()
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/

By Mikhail Gavrilov; 8 days ago; 5 activities, latest 7 days ago.
Introduced in 0d940a9b270b (v6.5-rc1)


drm/bridge: lt9611: Dragonboard 845c (SDM845) devboard broken when running AOSP
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/

By Amit Pundir; 18 days ago; 20 activities, latest 9 days ago.
Introduced in 8ddce13ae69 (v6.5-rc1)


kernel pointer dereference regression due to extract_iter_to_sg()
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

By Ondrej Mosnáček; 10 days ago; 2 activities, latest 9 days ago.
Introduced in c1abe6f570af (v6.5-rc1)


net: phylink: mv88e6060 dsa driver broken
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/
https://lore.kernel.org/netdev/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/

By Sergei Antonov; 19 days ago; 8 activities, latest 10 days ago.
Introduced in de5c9bf40c45 (v6.5-rc1)


blk-mq: NFS workload leaves nfsd threads in D state
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
https://lore.kernel.org/linux-block/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/

By Chuck Lever III; 14 days ago; 11 activities, latest 11 days ago.
Introduced in 615939a2ae73 (v6.5-rc1)

2 patch postings are associated with this regression, the latest is this:
* Re: NFS workload leaves nfsd threads in D state
  https://lore.kernel.org/linux-block/20230711120137.GA27050@lst.de/
  12 days ago, by Christoph Hellwig


Bluetooth: Dragonboard 845c (SDM845) devboard broken
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/

By Amit Pundir; 16 days ago; 5 activities, latest 13 days ago.
Introduced in 6945795bc81 (v6.5-rc1)


===================================================
current cycle (v6.4.. aka v6.5-rc), unknown culprit
===================================================


mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217675/
https://bugzilla.kernel.org/show_bug.cgi?id=217675
https://lore.kernel.org/lkml/51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com/

By rudi and rudi; 7 days ago; 7 activities, latest -1 days ago.
Introduced in v6.5-rc1..831fe284d827 (v6.5-rc1..v6.5-rc2)

Recent activities from: rudi (3), Ilan Peer (1), Bagas Sanjaya (1)

Noteworthy links:
* [PATCH v2] wifi: cfg80211: Fix return value in scan logic
  https://lore.kernel.org/linux-wireless/20230723201043.3007430-1-ilan.peer@intel.com/
  -1 days ago, by Ilan Peer; thread monitored.


mm/vmalloc: NULL or otherwise bad pointer dereferences on ARM64
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/
https://lore.kernel.org/lkml/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/

By Mark Brown; 13 days ago; 10 activities, latest 3 days ago.
Introduced in v6.4..v6.5-rc1

Recent activities from: Mark Brown (1), Will Deacon (1)

One patch associated with this regression:
* Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
  https://lore.kernel.org/lkml/b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com/
  12 days ago, by Hugh Dickins


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168951788956.3088691.6549033530966986041@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
