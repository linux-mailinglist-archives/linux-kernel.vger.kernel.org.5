Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DD7B47A4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjJANn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjJANn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:43:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D3AB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:43:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qmwjf-0006FY-CT; Sun, 01 Oct 2023 15:43:51 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-10-01]
Date:   Sun,  1 Oct 2023 13:43:50 +0000
Message-Id: <169616777754.3766264.2663767892794249034@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696167833;93ac41fa;
X-HE-SMSGID: 1qmwjf-0006FY-CT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. There is not much to report wrt to regressions introduced
during the current cycle; quite a few new reports showed up this week
(see below), but nothing to worry about afaics. And the 6.5-rc6
regression I mentioned in last weeks report is also soon history, as
Greg sent you the merge request with the fix today (see "[GIT PULL]
Char/Misc driver fix for 6.6-rc4").

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 8 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.5.. aka v6.6-rc), culprit identified
======================================================


[ *NEW* ] x86,static_call: crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZRhKq6e5nF/4ZIV1@fedora/
https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/

By Hyeonggon Yoo; 0 days ago; 1 activities, latest 0 days ago.
Introduced in aee9d30b9744 (v6.6-rc3)

Recent activities from: Hyeonggon Yoo (1)


[ *NEW* ] resume_console performance regression due to per-console suspended state
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com/
https://lore.kernel.org/lkml/99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com/

By Todd Brandt; 3 days ago; 2 activities, latest 1 days ago.
Introduced in 9e70a5e109a4 (v6.6-rc1)

Fix incoming:
* printk: flush consoles before checking progress
  https://lore.kernel.org/lkml/da91c950-51c0-4c71-855e-ae11898a97f5@gmail.com/


[ *NEW* ] resume_console performance regression due to per-console suspended state
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217955/
https://bugzilla.kernel.org/show_bug.cgi?id=217955
https://lore.kernel.org/lkml/99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com/

By Todd Brandt and Todd Brandt; 3 days ago; 15 activities, latest 1 days ago.
Introduced in 9e70a5e109a4 (v6.6-rc1)

Fix incoming:
* printk: flush consoles before checking progress
  https://lore.kernel.org/lkml/da91c950-51c0-4c71-855e-ae11898a97f5@gmail.com/


mm, memcg: runc fails to gather cgroup statistics
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
https://lore.kernel.org/lkml/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

By Jeremi Piotrowski; 11 days ago; 33 activities, latest 1 days ago.
Introduced in 86327e8eb94c (v6.6-rc1)

Fix incoming:
* mm, memcg: reconsider kmem.limit_in_bytes deprecation
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=7fb34d99d835ad56dc1827e0753ba53b7c27a2e4


wifi: mt76: mt7915: removal of VHT160 capability broke hostap
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/12289744.O9o76ZdvQC@natalenko.name/
https://lore.kernel.org/lkml/12289744.O9o76ZdvQC@natalenko.name/

By Oleksandr Natalenko; 10 days ago; 3 activities, latest 1 days ago.
Introduced in 3ec5ac12ac8a (v6.6-rc1)

Recent activities from: Oleksandr Natalenko (1), Nicolas Cavallari (1)


[ *NEW* ] powerpc: new page table range API causes PowerMac G5 to fail booting
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230929132750.3cd98452@yea/
https://lore.kernel.org/linuxppc-dev/20230929132750.3cd98452@yea/

By Erhard Furtner; 2 days ago; 1 activities, latest 2 days ago.
Introduced in 9fee28baa601 (v6.6-rc1)

Recent activities from: Erhard Furtner (1)


[ *NEW* ] Input: psmouse - Resume broken on T14s Gen1 (AMD) due to a new delay when deactivating for SMBus mode
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
https://lore.kernel.org/lkml/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
https://lore.kernel.org/lkml/0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info/

By Thorsten Leemhuis and Thorsten Leemhuis; 4 days ago; 4 activities, latest 3 days ago.
Introduced in 92e24e0e57f7 (v6.6-rc1)

Recent activities from: Thorsten Leemhuis (3), Jeffery Miller (1)


[ *NEW* ] virtio: network-related regression when using SWIOTLB in the guest
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230926130451.axgodaa6tvwqs3ut@amd.com/
https://lore.kernel.org/lkml/20230926130451.axgodaa6tvwqs3ut@amd.com/

By Michael Roth; 5 days ago; 4 activities, latest 4 days ago.
Introduced in 295525e29a (v6.6-rc1)

Fix incoming:
* virtio_net: fix the missing of the dma cpu sync
  https://lore.kernel.org/lkml/a7a2bf25-cfc1-47a8-baf4-487a8574fb5a@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169557219938.3206394.2779757887621800924@leemhuis.info

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
